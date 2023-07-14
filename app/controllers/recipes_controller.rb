class RecipesController < ApplicationController
  load_and_authorize_resource
  def index
    @recipes = Recipe.all.includes(:user).filter { |recip| recip.user_id == current_user.id }
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id
  end

  def update
  end

  def destroy
    @recipe.destroy
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public)
  end
  private :recipe_params
end