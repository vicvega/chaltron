require 'rails_helper'

describe User do

  context 'validation' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_uniqueness_of(:email) }

    context 'checks case sensitive' do
      subject { user }
      context 'for username' do
        before { create(:user, username: 'pippero') }
        let(:user) { build(:user, username: 'Pippero') }
        it { is_expected.to be_invalid }
      end
      context 'for email' do
        before { create(:user, email: 'pippero@example.org') }
        let(:user) { build(:user, email: 'Pippero@EXAMple.org') }
        it { is_expected.to be_invalid }
      end
    end
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
