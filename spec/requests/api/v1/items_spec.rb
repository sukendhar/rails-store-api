require 'rails_helper'

RSpec.describe "API::V1::Items", type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }
  let(:store) { create(:store) }
  let!(:items) { create_list(:item, 2, store: store) }

  describe "GET /api/v1/stores/:store_id/items" do
    it "returns all items for a store" do
      get "/api/v1/stores/#{store.id}/items", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(2)
    end

    it "returns 404 not_found if Store ID does not exist " do
      get "/api/v1/stores/70004/items", headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/stores/:store_id/items" do
    let(:params) { { item: { name: "Item test", price: 15.89, description: "test product" } } }
    let(:invalid_params) { { item: { name: "", price: "", description: "" } } }

    it "creates a new item" do
      expect {
        post "/api/v1/stores/#{store.id}/items", params: params.to_json, headers: headers
      }.to change(Item, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it "returns error for invalid params" do
      post "/api/v1/stores/#{store.id}/items", params: invalid_params.to_json, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to include("Name can't be blank", "Price can't be blank", "Description can't be blank")
    end
  end

  describe "PATCH /items/:id" do
    let(:item) { items.first }

    it "updates an item successfully" do
      patch "/api/v1/items/#{item.id}", params: { item: { name: "Updated item name" } }.to_json, headers: headers
      expect(response).to have_http_status(:ok)
      expect(item.reload.name).to eq("Updated item name")
    end

    it "returns 404 not_found for non existent item" do
      patch "/api/v1/items/700005", params: { item: { name: "Does not exist" } }.to_json, headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /items/:id" do
    let(:item_to_delete) { items.last }

    it "removes the item from the database and returns 204 no_content" do
      expect {
        delete "/api/v1/items/#{item_to_delete.id}", headers: headers
      }.to change(Item, :count).by(-1)

      expect(response).to have_http_status(:no_content)
    end

    it "returns 404 not_found response" do
      delete "/api/v1/items/700006", headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end
end
