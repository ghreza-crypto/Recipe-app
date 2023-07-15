class ShoppingListsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index]

  def index
    @recipes = Recipe.where(user_id: current_user.id)
    recipe_ids = @recipes.select(:id)
    recipe_foods = RecipeFood.where(recipe_id: recipe_ids).group(:food_id).sum(:quantity)
    @shopping_lists = []

    recipe_foods.keys.each do |food_id|
      food = Food.find(food_id)
      needed_food = 1 - recipe_foods[food_id]
      next unless needed_food.negative?

      name = food.name
      needed = needed_food.abs
      price = needed * food.price
      @shopping_lists << { name:, quantity: needed, price: }
    end

    @total_price = 0
    @shopping_lists.each do |food_id|
      @total_price += food_id[:price]
    end
  end
end
