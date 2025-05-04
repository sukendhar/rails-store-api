require 'rails_helper'

RSpec.describe "API::V1::Ingredients", type: :request do
  let(:item) { create(:item) }
  let!(:ingredients) { create_list(:ingredient, 2, item: item) }

  describe "GET /api/v1/items/:item_id/ingredients" do
    it "returns all ingredients for an item" do
      get "/api/v1/items/#{item.id}/ingredients"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST /api/v1/items/:item_id/ingredients" do
    let(:params) do
      {
        ingredient: {
          name: "Sugar",
          quantity: "500 gms"
        }
      }
    end

    it "creates a new ingredient" do
      expect {
        post "/api/v1/items/#{item.id}/ingredients", params: params
      }.to change(Ingredient, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end
end
