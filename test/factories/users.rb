FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "dumbledore_#{n}" }
    fullname { 'Albus Percival Wulfric Brian Dumbledore' }
    sequence(:email) { |n| "headmaster_#{n}@hogwarts.co.uk" }
    password { 'SuperS3cr3t!' }
    password_confirmation { password }
  end
end
