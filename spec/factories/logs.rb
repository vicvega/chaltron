FactoryGirl.define do
  factory :log do
    message { Faker::Lorem.sentences }
    severity 'info'
    category 'test category'
  end

end
