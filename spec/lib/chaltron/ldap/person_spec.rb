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

  describe 'search by dn' do
    subject(:res) { Chaltron::LDAP::Person.find_by_field 'dn', name }
    context 'returning 1 values' do
      let(:name) { 'uid=sirius,ou=people,dc=azkaban,dc=co,dc=uk' }
      it { is_expected.to be_an_instance_of Array }
      it { expect(res.size).to eq 1 }
      it { expect(res.first.uid).to eq 'sirius' }
    end
  end

  describe 'search by field' do
    subject(:res) { Chaltron::LDAP::Person.find_by_fields(title: title) }
    context 'returning 2 values' do
      let(:title) { '* guy' }
      it { is_expected.to be_an_instance_of Array }
      it { expect(res.size).to eq 2 }
      it { expect(res.first).to be_an_instance_of Chaltron::LDAP::Person }
    end
    context 'returning empty set' do
      let(:title) { 'test' }
      it { is_expected.to be_an_instance_of Array }
      it { expect(res.size).to eq 0 }
    end
  end

  describe 'search by multiple fields' do
    subject(:res) { Chaltron::LDAP::Person.find_by_fields(title: title, uid: 'sirius') }
    context 'returning 1 value' do
      let(:title) { '* guy' }
      it { is_expected.to be_an_instance_of Array }
      it { expect(res.size).to eq 1 }
      it { expect(res.first).to be_an_instance_of Chaltron::LDAP::Person }
    end
    context 'returning empty set' do
      let(:title) { 'test' }
      it { is_expected.to be_an_instance_of Array }
      it { expect(res.size).to eq 0 }
    end
  end

  describe 'create by uid' do
    subject(:barty) { Chaltron::LDAP::Person.find_by_uid('barty').create_user }

    context 'without fullname' do
      before do
        Chaltron.ldap_field_mappings = {
          first_name: 'givenName',
          last_name: 'sn',
          email: 'mail'
        }
      end
      it { expect(barty.provider).to eq 'ldap' }
      it { expect(barty.username).to eq 'barty' }
      it { expect(barty.fullname).to eq 'Bartemius Crouch' }
      it { expect(barty.email).to eq 'barty.crouch@azkaban.co.uk' }
      it { expect(barty.department).to be_nil }
    end
    context 'with fullname' do
      before do
        Chaltron.ldap_field_mappings = {
          full_name: 'displayName',
          first_name: 'givenName',
          last_name: 'sn',
          email: 'mail'
        }
      end
      it { expect(barty.provider).to eq 'ldap' }
      it { expect(barty.username).to eq 'barty' }
      it { expect(barty.fullname).to eq 'Bartemius Crouch Jr.' }
      it { expect(barty.email).to eq 'barty.crouch@azkaban.co.uk' }
      it { expect(barty.department).to be_nil }
    end

  end

end
