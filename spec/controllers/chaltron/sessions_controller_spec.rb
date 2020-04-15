require 'rails_helper'

RSpec.describe Devise::SessionsController, type: :controller do
  context 'devise' do
    before { @request.env['devise.mapping'] = Devise.mappings[:user] }
    let(:user) { create :user }

    context 'login' do
      it 'generates log message' do
        expect do
          post :create, params: { user: { login: user.username, password: user.password } }
        end.to change(Log, :count).by(1)
      end
    end

    context 'logout' do
      before do
        sign_in user
      end

      it 'generates log message' do
        expect { delete :destroy }.to change(Log, :count).by(1)
      end
    end

  end
end
