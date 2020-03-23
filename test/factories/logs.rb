FactoryBot.define do
  factory :log do
    message  { 'something occured' }
    severity { 'info' }
    category { 'test category' }
  end
end
