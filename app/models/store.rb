class Store < ApplicationRecord
  has_many :items, dependent: :destroy

  validates :name, presence: true, length: { minimum: 2 }
  validates :address, presence: true
  validates :description, presence: true
end
