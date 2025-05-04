require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe 'associations' do
    it { should belong_to(:item) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:quantity) }
  end
end
