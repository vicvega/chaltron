require 'rails_helper'

RSpec.describe Chaltron::LogsController, :type => :controller do
  let!(:user_login) { create :log, category: :user_admin }
  let!(:log_other) { create :log, category: :something_else }

  let(:admin) { create :admin }
  let(:user_admin) { create :user_admin }
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  let(:logs) { assigns('logs') }
  let(:log) { assigns('log') }

  context 'admin' do
    before { sign_in admin }
    it 'index all logs' do
      get :index
      expect(logs.count).to eq(2)
    end
    it 'show login' do
      get :show, id: user_login.id
      expect(log).to eq(log)
      expect(response).to render_template(:show)
    end
    it 'show other' do
      get :show, id: log_other.id
      expect(log).to eq(log)
      expect(response).to render_template(:show)
    end
  end

  context 'user_admin' do
    before { sign_in user_admin }
    it 'index just login logs' do
      get :index
      expect(logs.count).to eq(1)
    end
    it 'show login' do
      get :show, id: user_login.id
      expect(log).to eq(log)
      expect(response).to render_template(:show)
    end
    it 'does not show other' do
      get :show, id: log_other.id
      expect(response).to redirect_to(root_url)
    end
  end

end
