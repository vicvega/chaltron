require 'rails_helper'
require 'chaltron/ldap/person'

describe Chaltron::LDAP::Person do
  describe 'authentication' do
    subject { Chaltron::LDAP::Person.valid_credentials? 'sirius', password }
    context 'with correct credentials' do
      let(:password) { 'padfoot' }
      it { is_expected.to be }
    end
    context 'with incorrect credentials' do
      let(:password) { 'badpassword' }
      it { is_expected.to be_falsey }
    end
  end

  describe 'search by uid' do
    subject { Chaltron::LDAP::Person.find_by_uid uid }
    context 'existing' do
      let(:uid) { 'sirius' }
      it { is_expected.to be_an_instance_of Chaltron::LDAP::Person }
    end
    context 'not existing' do
      let(:uid) { 'someone' }
      it { is_expected.to be_nil }
    end
  end

end
