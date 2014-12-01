require 'rails_helper'
require 'chaltron/ldap/adapter'

describe Chaltron::LDAP::Adapter do
    context "authentication" do
      subject { Chaltron::LDAP::Adapter.valid_credentials? 'sirius', password }
      context "with correct credentials" do
        let(:password) { 'padfoot' }
        it { is_expected.to be }
      end
      context "with incorrect credentials" do
        let(:password) { 'badpassword' }
        it { is_expected.to be_falsey }
      end
    end

end
