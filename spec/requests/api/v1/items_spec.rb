require 'rails_helper'

RSpec.describe "API::V1::Items", type: :request do
  let(:store) { create(:store) }
  let!(:items) { create_list(:item, 2, store: store) }

  describe "GET /api/v1/stores/:store_id/items" do
    it "returns all items for a store" do
      get "/api/v1/stores/#{store.id}/items"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "POST /api/v1/stores/:store_id/items" do
    let(:params) do
      {
        item: {
          name: "Item test",
          price: 15.89,
          description: "test product"
        }
      }
    end

    it "creates a new item" do
      expect {
        post "/api/v1/stores/#{store.id}/items", params: params
      }.to change(Item, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end
end
