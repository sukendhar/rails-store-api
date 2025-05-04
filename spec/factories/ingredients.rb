FactoryBot.define do
  factory :ingredient do
    name     { Faker::Food.ingredient }
    quantity { Faker::Food.measurement }
    association :item
  end
end
