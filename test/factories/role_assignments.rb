FactoryBot.define do
  factory :role_assignment do
    user
    role
    association :assigned_by, factory: :user
  end
end
