require 'rails_helper'

RSpec.describe Store, type: :model do
  describe 'associations' do
    it { should have_many(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:description) }
  end
end
