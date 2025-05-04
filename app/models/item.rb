class Item < ApplicationRecord
  belongs_to :store
  has_many :ingredients, dependent: :destroy

  validates :name, :price, :description, presence: true
end
