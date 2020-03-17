require 'test_helper'
require 'generators/chaltron/install/install_generator'

class Chaltron::InstallGeneratorTest < Rails::Generators::TestCase
  tests Chaltron::InstallGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
