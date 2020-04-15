require 'rails_helper'
require 'chaltron/ldap/person'

describe User do
  context 'ldap' do

    subject { page }
    before {
      Chaltron.ldap_allow_all = true
      Chaltron.ldap_field_mappings = {
        first_name: 'givenName',
        last_name: 'sn',
        email: 'mail'
      }
      Chaltron.ldap_after_authenticate = -> (user, ldap) { user }
    }

    let(:fullname) { 'Sirius Black' }
    context 'when Chaltron.ldap_allow_all is true' do
      it 'allows login and logout' do
        login_with 'sirius', 'padfoot', :ldap
        is_expected.to have_content fullname
        logout
        is_expected.to have_content 'Login'
        is_expected.not_to have_content fullname
      end

      context 'when Chaltron.default_roles is set' do
        before {
          Chaltron.ldap_allow_all = true
          Chaltron.default_roles = ['admin']
        }
        it 'allows login and set roles' do
          login_with 'sirius', 'padfoot', :ldap
          is_expected.to have_content fullname
          logout
          is_expected.to have_content 'Login'
          is_expected.not_to have_content fullname

          expect(User.find_by(username: 'sirius').is?(:admin)).to be_truthy
          expect(User.find_by(username: 'sirius').is?(:user_admin)).to be_falsey
        end
      end

      context 'when Chaltron.ldap_role_mappings is set' do
        before do
          Chaltron.ldap_allow_all = true
          Chaltron.ldap_group_base = 'ou=groups,dc=azkaban,dc=co,dc=uk'
          Chaltron.ldap_group_member_filter = -> (entry) { "memberUid=#{entry.uid}" }
          Chaltron.ldap_role_mappings = {
            'cn=good,ou=groups,dc=azkaban,dc=co,dc=uk' => 'admin'
          }
        end
        context 'admin' do
          it 'allows login and set roles' do
            login_with 'sirius', 'padfoot', :ldap
            is_expected.to have_content fullname
            logout
            is_expected.to have_content 'Login'
            is_expected.not_to have_content fullname

            expect(User.find_by(username: 'sirius').is?(:admin)).to be_truthy
            expect(User.find_by(username: 'sirius').is?(:user_admin)).to be_falsey
          end
        end
        context 'no roles' do
          let(:fullname) { 'Bartemius Crouch' }
          it 'allows login and set roles' do
            login_with 'barty', 'darklord', :ldap
            is_expected.to have_content fullname
            logout
            is_expected.to have_content 'Login'
            is_expected.not_to have_content fullname

            expect(User.find_by(username: 'barty').is?(:admin)).to be_falsey
            expect(User.find_by(username: 'barty').is?(:user_admin)).to be_falsey
          end
        end
      end

    end

    context 'when Chaltron.ldap_allow_all is not true' do
      before { Chaltron.ldap_allow_all = false }
      it 'does not allow login' do
        login_with 'sirius', 'padfoot', :ldap
        is_expected.to have_content I18n.t('chaltron.not_allowed_to_sign_in')
      end
    end

    context 'when Chaltron.ldap_after_authenticate returns nil' do
      before { Chaltron.ldap_after_authenticate = -> (user, ldap) { nil } }
      it 'does not allow login' do
        login_with 'sirius', 'padfoot', :ldap
        is_expected.to have_content I18n.t('chaltron.not_allowed_to_sign_in')
      end
    end

    context 'when user already present with outdated email' do
      before do
        u = Chaltron::LDAP::Person.find_by_uid('barty').create_user
        u.update_attribute :email, 'barty@example.com'
      end
      subject(:user) { User.find_by(username: 'barty') }
      it 'update email' do
        login_with 'barty', 'darklord', :ldap
        expect(user.email).to eq 'barty.crouch@azkaban.co.uk'
      end
    end
  end

  context 'local' do
    let(:user) { create :user }
    it 'allows login and logout' do
      login_with user.username, user.password
      expect(page).to have_content user.fullname
      logout
      expect(page).to have_content 'Login'
      expect(page).not_to have_content user.fullname
    end

    it 'allows login with email' do
      login_with user.email, user.password
      expect(page).to have_content user.fullname
      logout
      expect(page).to have_content 'Login'
      expect(page).not_to have_content user.fullname
    end

    it 'recovers password' do
      visit new_user_session_path
      click_link I18n.t('devise.passwords.new.title')

      fill_in 'user_email', with: user.email
      expect { click_button I18n.t('devise.passwords.new.submit_text') }.to change{
       ActionMailer::Base.deliveries.count
      }.by(1)

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to).to eq [user.email]

      urls = URI.extract(mail.body.to_s)
      expect(urls.count).to eq 1

      visit urls.first
      password = 'password.1'

      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password
      click_button I18n.t('devise.passwords.edit.submit_text')

      expect(page).to have_content user.fullname
    end

    it 'does not allow login to disabled users' do
      user.disable!

      login_with user.reload.email, user.password
      expect(page).to have_content user.inactive_message
    end

  end
end
