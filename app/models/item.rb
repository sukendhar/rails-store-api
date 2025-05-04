class Item < ApplicationRecord
  belongs_to :store
  has_many :ingredients, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true
end
