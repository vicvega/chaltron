FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "dumbledore_#{n}" }
    fullname { 'Albus Percival Wulfric Brian Dumbledore' }
    sequence(:email) { |n| "headmaster_#{n}@hogwarts.co.uk" }
    password { '12345678' }
    password_confirmation { password }
  end
end
