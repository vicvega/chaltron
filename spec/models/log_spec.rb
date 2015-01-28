require 'rails_helper'

RSpec.describe Log, type: :model do

 context 'validation' do
    it { should validate_presence_of(:severity) }
    it { should validate_presence_of(:message) }
  end

end
