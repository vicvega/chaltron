require 'rails_helper'

RSpec.describe Chaltron::LogsController, :type => :controller do
  let!(:log)  { create :log, category: :login }
  let!(:log2) { create :log, category: :something_else }

  let(:admin) { create :admin }
  let(:user_admin) { create :user_admin }
  before { @request.env["devise.mapping"] = Devise.mappings[:user] }

  subject(:logs) { assigns('logs') }

  context 'admin' do
    before { sign_in admin }
    it 'views all logs' do
      get :index
      expect(logs.count).to eq(2)
    end
  end

  context 'user_admin' do
    before { sign_in user_admin }
    it 'views just login logs' do
      get :index
      expect(logs.count).to eq(1)
    end
  end

end
