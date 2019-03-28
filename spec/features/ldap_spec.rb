require 'rails_helper'

describe User do

  context 'user_admin', js: true do

    let(:user_admin) { create :user_admin }
    before { login_with user_admin.username, user_admin.password }
    subject { page }

    it 'creates LDAP user by uid' do
      visit users_path

      click_button I18n.t('chaltron.users.index.new_user')
      click_link I18n.t('chaltron.users.index.new_ldap_user')
      fill_in 'userid', with: 'sirius'
      click_button I18n.t('chaltron.ldap.search.submit_text')

      is_expected.to have_content 'sirius'

      find('table#ldap_create tr', text: 'sirius').click
      check :user_roles_admin
      check :user_roles_user_admin
      click_button I18n.t('chaltron.ldap.multi_new.submit_text')

      is_expected.to have_css 'li.list-group-item-success'
      is_expected.to have_content 'Sirius Black'
      is_expected.not_to have_css 'div.panel-danger'

      expect(User.find_by(username: 'sirius').is? :admin).to be_truthy
      expect(User.find_by(username: 'sirius').is? :user_admin).to be_truthy
    end

    it 'creates LDAP users by name' do
      visit users_path

      click_button I18n.t('chaltron.users.index.new_user')
      click_link I18n.t('chaltron.users.index.new_ldap_user')
      click_button I18n.t('chaltron.ldap.search.submit_text')

      is_expected.to have_content 'sirius'
      is_expected.to have_content 'barty'

      find('table#ldap_create tr', text: 'sirius').click
      find('table#ldap_create tr', text: 'barty').click

      check :user_roles_admin
      click_button I18n.t('chaltron.ldap.multi_new.submit_text')

      is_expected.to have_css 'li.list-group-item-success'
      is_expected.to have_content 'Bartemius Crouch'
      is_expected.to have_content 'Sirius Black'
      is_expected.not_to have_css 'div.panel-danger'

      expect(User.find_by(username: 'sirius').is? :admin).to be_truthy
      expect(User.find_by(username: 'barty').is? :admin).to be_truthy
    end

 end

end
