class Ingredient < ApplicationRecord
  belongs_to :item

  validates :name, :quantity, presence: true
end
