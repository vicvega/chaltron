require 'rails_helper'

describe User do
  context 'logged' do
    let(:user) { create :user }
    before { login_with user.username, user.password }

    it 'edits account data' do
      visit self_show_path

      expect(page).to have_content user.fullname

      click_link 'Edit account data'

      fullname = 'emmeline vance'
      fill_in 'user_fullname', with: fullname
      click_button 'Edit account data'

      expect(page).to have_content I18n.t('chaltron.users.self_updated')
      expect(page).to have_content fullname
    end

  end
end
