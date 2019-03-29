require 'rails_helper'
require 'chaltron/ldap/connection'

describe Chaltron::LDAP::Connection do

  describe 'LDAP' do

    let(:ldap) { Chaltron::LDAP::Connection.new }

    context 'find users' do
      context 'by dn' do
        subject(:res) { ldap.find_users(dn: dn) }
        context 'returns right value' do
          let(:dn) { 'uid=sirius,ou=people,dc=azkaban,dc=co,dc=uk' }
          it { is_expected.to be_an_instance_of Array }
          it { expect(res.size).to eq 1 }
          it { expect(res.first.uid).to eq 'sirius' }
        end
        context 'returns empty' do
          let(:dn) { 'somenthing here' }
          it { is_expected.to be_an_instance_of Array }
          it { expect(res.size).to eq 0 }
        end
      end

      context 'by custom field' do
        subject(:res) { ldap.find_users(title: title) }
        context 'returns right 2 values' do
          let(:title) { '*guy' }
          it { is_expected.to be_an_instance_of Array }
          it { expect(res.size).to eq 2 }
        end
        context 'returns right value' do
          let(:title) { 'Bad guy' }
          it { is_expected.to be_an_instance_of Array }
          it { expect(res.size).to eq 1 }
          it { expect(res.first.uid).to eq 'barty' }
        end
      end
    end

    context 'find_by_uid' do
      subject(:res) { ldap.find_by_uid(uid) }
      context 'returns right value' do
        let(:uid) { 'sirius' }
        it { is_expected.to be_an_instance_of Chaltron::LDAP::Person }
        it { expect(res.uid).to eq 'sirius' }
      end
      context 'returns nil' do
        let(:uid) { 'nothing' }
        it { is_expected.to be_nil }
      end
    end

    context 'find_groups_by_member' do
      before {
        Chaltron.ldap_group_base = 'ou=groups,dc=azkaban,dc=co,dc=uk'
      }

      subject(:res) { ldap.find_groups_by_member(user) }
      context 'returns right value' do
        let(:user) { 'Sirius Black' }
        it { is_expected.not_to be_empty }
      end
      context 'returns empty' do
        let(:user) { 'Bartemius Crouch' }
        it { is_expected.to be_empty }
      end
    end

  end

end
