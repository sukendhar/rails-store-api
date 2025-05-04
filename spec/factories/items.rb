FactoryBot.define do
  factory :item do
    name        { Faker::Food.dish }
    price       { Faker::Commerce.price(range: 5..30.0) }
    description { Faker::Food.description }
    association :store
  end
end
