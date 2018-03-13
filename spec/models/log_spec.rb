require 'rails_helper'

RSpec.describe Log, type: :model do

 context 'validation' do
    it { should validate_presence_of(:severity) }
    it { should validate_presence_of(:message) }

    context 'severity' do
      subject { log }
      let(:log) { build(:log, severity: severity) }
      context 'good' do
        let(:severity) { 'notice' }
        it { is_expected.to be_valid }
      end
      context 'syslog' do
        let(:severity) { 'error' }
        it do
          is_expected.to be_valid
          expect(log.severity).to eq('err')
        end
      end
      context 'bad' do
        let(:severity) { 'bad' }
        it { is_expected.to be_invalid }
      end
    end
  end

end
