require 'rails_helper'

RSpec.describe 'Food integration tests', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(name: 'John', email: 'john@gmail.com', password: '123456', password_confirmation: '123456')
    @first_food = Food.create(name: 'Apple', user_id: @user.id, measurement_unit: 'grams', price: 10, quantity: 1)
    @second_food = Food.create(name: 'Banana', user_id: @user.id, measurement_unit: 'grams', price: 20, quantity: 1)
    @third_food = Food.create(name: 'Orange', user_id: @user.id, measurement_unit: 'grams', price: 30, quantity: 1)
    @foods = [@first_food, @second_food, @third_food]

    login_as(@user, scope: :user)
  end

  describe 'index page' do
    before { visit foods_path }

    it 'should display the title "Food"' do
      expect(page).to have_content('Food')
    end

    it 'should display a table with the foods' do
      expect(page).to have_selector('table')
    end

    it 'should display a link to create a new food' do
      expect(page).to have_link('Add New Food', href: new_food_path)
    end

    it 'should dsiplay each food details' do
      @foods.each do |food|
        expect(page).to have_content(food.name)
        expect(page).to have_content(food.measurement_unit)
        expect(page).to have_content(food.price)
        expect(page).to have_content(food.quantity)
      end
    end
  end
end
