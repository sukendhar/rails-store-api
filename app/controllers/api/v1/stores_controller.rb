class Api::V1::StoresController < ApplicationController
  before_action :set_store, only: %i[show update destroy items_count]

  def index
    render json: Store.all, status: :ok
  end

  def show
    render json: @store, status: :ok
  end

  def create
    store = Store.new(store_params)
    if store.save
      # Enqueue the job to send notification email
      StoreNotifyJob.perform_later(store.id)

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

  def items_count
    render json: { items_count: @store.items.count }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Store not found" }, status: :not_found
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
