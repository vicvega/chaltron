FactoryBot.define do
  factory :log do
    message { FFaker::Lorem.sentences }
    severity 'info'
    category 'test category'
  end

end
