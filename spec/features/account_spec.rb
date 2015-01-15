require 'rails_helper'

describe User do
  context 'logged' do
    let(:user) { create :user }
    before { login_with user.username, user.password }

    it 'edits account data' do
      visit self_show_users_path
      expect(page).to have_content user.fullname

      click_link I18n.t('chaltron.users.self_edit.title')

      fullname = 'emmeline vance'
      fill_in 'user_fullname', with: fullname
      click_button I18n.t('chaltron.users.self_edit.title')

      expect(page).to have_content I18n.t('chaltron.users.self_updated')
      expect(page).to have_content fullname
    end

    it 'changes password' do
      visit self_show_users_path
      expect(page).to have_content user.fullname

      click_link I18n.t('chaltron.users.self_edit.title')

      password = 'password.1'
      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password
      click_button I18n.t('chaltron.users.self_edit.title')

      expect(page).to have_content I18n.t('chaltron.users.self_updated')

      logout
      login_with user.username, password
      expect(page).to have_content I18n.t('devise.sessions.signed_in')
    end

  end
end
