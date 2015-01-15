require 'rails_helper'

describe User do

  context 'user without priviledge' do
    let(:user) { create :user }
    before { login_with user.username, user.password }

    context 'trying to create user' do
      it 'gets access denied' do
        visit users_path
        expect(page).to have_content I18n.t('chaltron.access_denied')
      end

    end
  end


end  
