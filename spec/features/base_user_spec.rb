require 'rails_helper'

describe 'Basic user feature' do

  describe 'local user' do
    before do
      @user = create :user
    end

    it 'should login and logout' do
      login_with @user.username, @user.password
      expect(page).to have_content @user.fullname
      logout
      expect(page).to have_content 'Login'
      expect(page).not_to have_content @user.fullname
    end

    it 'should recover password' do
      visit new_user_session_path
      click_link 'Resetta la password'

      fill_in 'user_email', with: @user.email
      expect { click_button 'Invia' }.to change {ActionMailer::Base.deliveries.count}.by(1)

      mail = ActionMailer::Base.deliveries.last
      expect(mail.to).to eq [@user.email]

      urls = URI.extract(mail.body.to_s)
      expect(urls.count).to eq 1

      visit urls.first
      password = 'password.1'

      fill_in 'user_password', with: password
      fill_in 'user_password_confirmation', with: password
      click_button 'Cambia password'

      expect(page).to have_content @user.fullname
    end
  end

end
