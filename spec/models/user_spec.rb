require 'rails_helper'

describe User do

  describe 'validation' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:email) }

    describe 'case sensitive' do
      it 'checks username' do
        create(:user, username: 'pippero')
        user = build(:user, username: 'Pippero')
        expect(user).to be_invalid
      end

      it 'checks email' do
        create(:user, email: 'pippero@example.org')
        user = build(:user, email: 'Pippero@EXAMple.org')
        expect(user).to be_invalid
      end
    end
  end

  it 'checks fullname' do
    user = build(:user, username: 'pippo', fullname: 'super pippo')
    expect(user.display_name).to eq('super pippo')

    user = build(:user, username: 'pippo', fullname: nil)
    expect(user.display_name).to eq('pippo')
  end

end
