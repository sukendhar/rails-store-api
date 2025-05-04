class Api::V1::ItemsController < ApplicationController
  before_action :set_store, only: %i[index create]
  before_action :set_item, only: %i[show update destroy]

  def index
    render json: @store.items, status: :ok
  end

  def show
    render json: @item, status: :ok
  end

  def create
    item = @store.items.new(item_params)
    if item.save
      render json: item, status: :created
    else
      render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      render json: @item, status: :ok
    else
      render json: { errors: @item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    head :no_content
  end

  private

  def set_store
    @store = Store.find(params[:store_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Store not found" }, status: :not_found
  end

  def set_item
    @item = Item.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Item not found" }, status: :not_found
  end

  def item_params
    params.require(:item).permit(:name, :price, :description, :store_id)
  end
end
