require 'rails_helper'

RSpec.describe Recipe, type: :model do
  before(:each) do
    @user = User.create(name: 'John', email: 'john@gmail.com', password: '123456', password_confirmation: '123456')
    @recipe = Recipe.new(name: 'Sandwich', description: 'Is a sandwich', preparation_time: '10 min',
                         cooking_time: '3 min', public: true, user_id: @user.id)
  end

  describe 'initialize' do
    it 'should create a new recipe' do
      expect(@recipe).to be_a(Recipe)
    end

    it 'should have the attributes' do
      expect(@recipe).to have_attributes(name: 'Sandwich', description: 'Is a sandwich', preparation_time: '10 min',
                                         cooking_time: '3 min', public: true, user_id: @user.id)
    end
  end

  describe 'validations' do
    before(:each) do
      expect(@recipe).to be_valid
    end

    it 'should validate presence of name' do
      @recipe.name = nil
      expect(@recipe).to_not be_valid
    end

    it 'should validate length of name' do
      @recipe.name = 'a' * 251
      expect(@recipe).to_not be_valid
    end

    it 'should validate presence of description' do
      @recipe.description = nil
      expect(@recipe).to_not be_valid
    end

    it 'should validate presence of preparation_time' do
      @recipe.preparation_time = nil
      expect(@recipe).to_not be_valid
    end

    it 'should validate presence of cooking_time' do
      @recipe.cooking_time = nil
      expect(@recipe).to_not be_valid
    end
  end
end
