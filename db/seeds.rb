# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'

10.times do
  store = Store.create!(
    name: Faker::Restaurant.name,
    address: Faker::Address.full_address,
    description: Faker::Restaurant.description
  )

  rand(5..20).times do
    item = store.items.create!(
      name: Faker::Food.dish,
      price: Faker::Commerce.price(range: 5..30.0),
      description: Faker::Food.description
    )

    rand(5..10).times do
      item.ingredients.create!(
        name: Faker::Food.ingredient,
        quantity: Faker::Food.measurement
      )
    end
  end
end
