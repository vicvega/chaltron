require 'rails_helper'

describe User do

  context 'validation' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:username).case_insensitive.scoped_to(:provider) }
    it { should validate_uniqueness_of(:email).case_insensitive }
  end

  context 'display_name' do
    subject { user }
    context 'with existing fullname' do
      let(:user) { build(:user, username: 'pippo', fullname: 'super pippo') }
      it 'display fullname' do
        expect(user.display_name).to be user.fullname
      end
    end
    context 'with nil fullname' do
      let(:user) { build(:user, username: 'pippo', fullname: nil) }
      it 'display username' do
        expect(user.display_name).to be user.username
      end
    end
  end
end
