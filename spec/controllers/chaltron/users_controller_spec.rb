require 'rails_helper'

RSpec.describe Chaltron::UsersController, type: :controller do
  describe 'delete' do
    let!(:user) { create :user }
    let(:user_admin) { create :user_admin }
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in user_admin
    end

    context 'user' do
      it 'destroy user' do
        delete :destroy, id: user.id
        expect(User.count).to eq 1
        expect(flash[:alert]).to be_nil
      end
    end
    context 'current user' do
      it 'cannot self destroy' do
        delete :destroy, id: user_admin.id
        expect(User.count).to eq 2
        expect(flash[:alert]).to eq I18n.t('chaltron.users.cannot_self_destroy')
      end
    end

  end
end
