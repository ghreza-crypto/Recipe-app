class FoodsController < ApplicationController
  def index
    @foods = Food.all
  end

  def new
    @food = Food.new
  end

  def create
    @food = current_user.foods.build(food_params)

    if @food.save
      flash[:notice] = 'Food created successfully'
      redirect_to foods_path
    else
      flash[:alert] = 'Food could not be created'
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])

    if @food.destroy
      flash[:notice] = 'Food deleted successfully'
      redirect_to foods_path
    else
      flash[:alert] = 'Food could not be deleted'
      render :index
    end
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price)
  end
end
