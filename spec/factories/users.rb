# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "#{Faker::Internet.user_name}_#{n}" }
    fullname Faker::Name.name
    email { Faker::Internet.email }
    password '12345678'
    password_confirmation { password }

    factory :admin do
      after(:build) {|user| user.roles = ['admin']}
    end
    factory :user_admin do
      after(:build) {|user| user.roles = ['user_admin']}
    end
  end
end
