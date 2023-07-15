require 'rails_helper'

RSpec.describe 'Recipe integration tests', type: :feature do
  include Devise::Test::IntegrationHelpers

  before(:each) do
    @user = User.create(name: 'John', email: 'john@gmail.com', password: '123456', password_confirmation: '123456')
    @recipe = Recipe.create(name: 'Apple Pie', preparation_time: '10 minutes', cooking_time: '20 minutes', description: 'This is a description', public: true, user_id: @user.id)

    allow_any_instance_of(ApplicationController).to receive(:authorize!).and_return(true)
    login_as(@user, scope: :user)
  end

  describe 'index page' do
    before { visit recipes_path }

    it 'should display the title "Recipes"' do
      expect(page).to have_content('Recipes')
    end

    it 'should display a link to create a new recipe' do
      expect(page).to have_link('New Recipe', href: new_recipe_path)
    end

    it 'should display each recipe name and description' do
      expect(page).to have_content(@recipe.name)
      expect(page).to have_content(@recipe.description)
    end

    it 'should display a link to delete each recipe' do
      expect(page).to have_link('Remove', href: recipe_path(@recipe))
    end
  end

  describe 'show page' do
    before { visit recipe_path(@recipe) }

    it 'should display the recipe name' do
      expect(page).to have_content(@recipe.name)
    end

    it 'should display the recipe description' do
      expect(page).to have_content(@recipe.description)
    end

    it 'should display the recipe preparation time' do
      expect(page).to have_content(@recipe.preparation_time)
    end

    it 'should display the recipe cooking time' do
      expect(page).to have_content(@recipe.cooking_time)
    end

    it 'should display the recipe public status' do
      expect(page).to have_content('Public')
    end

    it 'should display a link to generate shopping list' do
      expect(page).to have_link('Generate Shopping List', href: shopping_lists_path)
    end

    it 'should display a link to add a new ingredient' do
      expect(page).to have_link('Add ingredient', href: new_recipe_recipe_food_path(@recipe))
    end
  end

  describe 'new page' do
    before { visit new_recipe_path }

    it 'should display the title "New Recipe"' do
      expect(page).to have_content('New recipe')
    end

    it 'should display a form to create a new recipe' do
      expect(page).to have_selector('form')
    end

    it 'should display the following fields: name, description, preparation time, cooking time, public' do
      expect(page).to have_field('Name')
      expect(page).to have_field('Description')
      expect(page).to have_field('Preparation time')
      expect(page).to have_field('Cooking time')
      expect(page).to have_field('Public')
    end

    it 'should display a link to go back to the recipes index page' do
      expect(page).to have_link('Back', href: recipes_path)
    end
  end
end