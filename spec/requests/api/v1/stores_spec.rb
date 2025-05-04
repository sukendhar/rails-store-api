require 'rails_helper'

RSpec.describe 'Stores API', type: :request do
  let!(:stores) { create_list(:store, 3) }
  let(:store_id) { stores.first.id }

  describe 'GET /api/v1/stores' do
    it 'list all stores' do
      get '/api/v1/stores'
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'GET /api/v1/stores/:id' do
    it 'show store details' do
      get "/api/v1/stores/#{store_id}"
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(store_id)
    end
  end

  describe 'POST /api/v1/stores' do
    let(:valid_params) { { store: { name: 'Test Store', address: '123 St', description: 'Desc' } } }

    it 'creates store' do
      expect {
        post '/api/v1/stores', params: valid_params
      }.to change(Store, :count).by(1)
      expect(response).to have_http_status(:created)
    end
  end

  describe 'PATCH /api/v1/stores/:id' do
    it 'updates the store info' do
      patch "/api/v1/stores/#{store_id}", params: { store: { name: 'Updated' } }
      expect(response).to have_http_status(:ok)
      expect(Store.find(store_id).name).to eq('Updated')
    end
  end

  describe 'DELETE /api/v1/stores/:id' do
    it 'deletes the store' do
      expect {
        delete "/api/v1/stores/#{store_id}"
      }.to change(Store, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end
end
