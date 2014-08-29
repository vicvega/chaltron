# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) {|n| "greg_#{n}"}
    fullname "Gaylord Focker"
    email { Faker::Internet.email }
    password "12345678"
    password_confirmation { password }
  end
end
