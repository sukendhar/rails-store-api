class Ingredient < ApplicationRecord
  belongs_to :item

  validates :name, presence: true, length: { minimum: 2 }
  validates :quantity, presence: true # Quantity is a string, as we need to store units like tablespoon, cup, ounce etc.
end
