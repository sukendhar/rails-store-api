require 'rails_helper'

RSpec.describe 'Stores API', type: :request do
  let(:user) { create(:user) }
  let(:headers) { auth_headers(user) }
  let!(:stores) { create_list(:store, 3) }
  let(:store_id) { stores.first.id }

  describe 'GET /api/v1/stores' do
    it 'list all stores' do
      get '/api/v1/stores', headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET /api/v1/stores/:id' do
    it 'show store details' do
      get "/api/v1/stores/#{store_id}", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(store_id)
    end

    it "returns not_found 404 for invalid Store ID " do
      get "/api/v1/stores/70000", headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST /api/v1/stores' do
    let(:valid_params) { { store: { name: 'Test Store', address: '123 St', description: 'Desc' } } }
    let(:invalid_params) { { store: { name: "", address: "", description: "" } } }

    it 'creates store' do
      expect {
        post '/api/v1/stores', params: valid_params.to_json, headers: headers
      }.to change(Store, :count).by(1)
      expect(response).to have_http_status(:created)
    end

    it 'returns error for invalid params' do
      post '/api/v1/stores', params: invalid_params.to_json, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to include("Name can't be blank", "Address can't be blank", "Description can't be blank")
    end
  end

  describe 'PATCH /api/v1/stores/:id' do
    it 'updates the store info' do
      patch "/api/v1/stores/#{store_id}", params: { store: { name: 'Updated' } }.to_json, headers: headers
      expect(response).to have_http_status(:ok)
      expect(Store.find(store_id).name).to eq('Updated')
    end

    it 'returns 404 not_found for invalid Store ID ' do
      patch "/api/v1/stores/70001", params: { store: { name: 'Updated' } }.to_json, headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE /api/v1/stores/:id' do
    it 'deletes the store' do
      expect {
        delete "/api/v1/stores/#{store_id}", headers: headers
      }.to change(Store, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it 'returns 404 not_found for invalid Store ID ' do
      delete "/api/v1/stores/70002", headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'GET /api/v1/stores/:id/items_count' do
    it 'returns the count of items for a store' do
      get "/api/v1/stores/#{store_id}/items_count", headers: headers
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['items_count']).to eq(0)
    end

    it 'returns 404 not_found for invalid Store ID ' do
      get "/api/v1/stores/70009/items_count", headers: headers
      expect(response).to have_http_status(:not_found)
    end
  end
end
