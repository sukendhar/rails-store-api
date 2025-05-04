FactoryBot.define do
  factory :store do
    name        { Faker::Restaurant.name }
    address     { Faker::Address.full_address }
    description { Faker::Restaurant.description }
  end
end
