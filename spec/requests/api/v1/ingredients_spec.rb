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
    let(:params) { { ingredient: { name: "Sugar", quantity: "500 gms" } } }
    let(:invalid_params) { { ingredient: { name: "", quantity: "" } } }

    it "creates a new ingredient" do
      expect {
        post "/api/v1/items/#{item.id}/ingredients", params: params
      }.to change(Ingredient, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it "returns error for invalid params" do
      post "/api/v1/items/#{item.id}/ingredients", params: invalid_params
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to include("Name can't be blank", "Quantity can't be blank")
    end
  end

  describe "PATCH /ingredients/:id" do
    let(:ingredient) { ingredients.first }

    it "updates an ingredient successfully" do
      patch "/api/v1/ingredients/#{ingredient.id}", params: { ingredient: { name: "Updated ingredient name" } }
      expect(response).to have_http_status(:ok)
      expect(ingredient.reload.name).to eq("Updated ingredient name")
    end

    it "returns 404 not_found for non existent ingredient" do
      patch "/api/v1/ingredients/700007", params: { ingredient: { name: "Does not exist" } }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "DELETE /ingredients/:id" do
    let(:ingredient_to_delete) { ingredients.last }

    it "removes the ingredient from the database and returns 204 no_content" do
      expect {
        delete "/api/v1/ingredients/#{ingredient_to_delete.id}"
      }.to change(Ingredient, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it "returns 404 not_found for non existent ingredient" do
      delete "/api/v1/ingredients/700008"
      expect(response).to have_http_status(:not_found)
    end
  end
end
