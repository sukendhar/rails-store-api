require 'rails_helper'

RSpec.describe Store, type: :model do
  describe 'associations' do
    it { should have_many(:items).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(2) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:description) }
  end
end
