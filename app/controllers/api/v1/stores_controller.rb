class Api::V1::StoresController < ApplicationController
  before_action :set_store, only: %i[show update destroy]

  def index
    render json: Store.all, status: :ok
  end

  def show
    render json: @store, status: :ok
  end

  def create
    store = Store.new(store_params)
    if store.save
      render json: store, status: :created
    else
      render json: { errors: store.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @store.update(store_params)
      render json: @store, status: :ok
    else
      render json: { errors: @store.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @store.destroy
    head :no_content
  end

  private

  def set_store
    @store = Store.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Store not found" }, status: :not_found
  end

  def store_params
    params.require(:store).permit(:name, :address, :description)
  end
end
