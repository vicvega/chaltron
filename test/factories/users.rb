FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "dumbledore_#{n}" }
    fullname { 'Albus Percival Wulfric Brian Dumbledore' }
    sequence(:email) { |n| "headmaster_#{n}@hogwarts.co.uk" }
    password { '12345678' }
    password_confirmation { password }

    factory :admin do
      after(:build) { |user| user.roles = [Role.find_by_name('admin')] }
    end
    factory :user_admin do
      after(:build) { |user| user.roles = [Role.find_by_name('user_admin')] }
    end
  end
end
