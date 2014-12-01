require 'rails_helper'

describe User do
  describe 'ldap' do
    let(:fullname) { 'Sirius Black' }

    context 'when Chaltron.ldap_allow_all is true' do
      before { Chaltron.ldap_allow_all = true }
      it 'allows login and logout' do
        login_with 'sirius', 'padfoot', :ldap
        expect(page).to have_content fullname
        logout
        expect(page).to have_content 'Login'
        expect(page).not_to have_content fullname
      end
    end

    context 'when Chaltron.ldap_allow_all is not true' do
      before { Chaltron.ldap_allow_all = false }
      it 'does not allow login' do
        login_with 'sirius', 'padfoot', :ldap
        expect(page).to have_content I18n.t('chaltron.not_allowed_to_sign_in')
      end
    end
  end

  describe 'local' do
    let(:user) { create :user }

    it 'allows login and logout' do
      login_with user.username, user.password
      expect(page).to have_content user.fullname
      logout
      expect(page).to have_content 'Login'
      expect(page).not_to have_content user.fullname
    end

    it 'recovers password' do
      visit new_user_session_path
      click_link 'Hai dimenticato la password?'

      fill_in 'user_email', with: user.email
      expect { click_button 'Invia' }.to change { ActionMailer::Base.deliveries.count }.by(1)

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to).to eq [user.email]

      urls = URI.extract(mail.body.to_s)
      expect(urls.count).to eq 1

      visit urls.first
      password = 'password.1'

      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password
      click_button 'Cambia password'

      expect(page).to have_content user.fullname
    end
  end
end
