class Api::V1::IngredientsController < ApplicationController
  before_action :set_item, only: %i[index create]
  before_action :set_ingredient, only: %i[show update destroy]

  def index
    render json: @item.ingredients, status: :ok
  end

  def show
    render json: @ingredient, status: :ok
  end

  def create
    ingredient = @item.ingredients.new(ingredient_params)
    if ingredient.save
      render json: ingredient, status: :created
    else
      render json: { errors: ingredient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @ingredient.update(ingredient_params)
      render json: @ingredient, status: :ok
    else
      render json: { errors: @ingredient.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @ingredient.destroy
    head :no_content
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Item not found" }, status: :not_found
  end

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Ingredient not found" }, status: :not_found
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :quantity, :item_id)
  end
end
