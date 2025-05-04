class Store < ApplicationRecord
  has_many :items

  validates :name, :address, :description, presence: true
end
