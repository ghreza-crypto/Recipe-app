require 'rails_helper'

RSpec.describe Food, type: :model do
  before(:each) do
    @user = User.create(name: 'John', email: 'john@gmail.com', password: '123456', password_confirmation: '123456')
    @food = Food.new(name: 'Apple', user_id: @user.id, measurement_unit: 'grams', price: 10, quantity: 1)
  end

  describe 'Initialize' do
    it 'should create a new food' do
      expect(@food).to be_a(Food)
    end

    it 'should have the attributes' do
      expect(@food).to have_attributes(name: 'Apple', user_id: @user.id, measurement_unit: 'grams', price: 10,
                                       quantity: 1)
    end
  end

  describe 'Validations' do
    before(:each) do
      expect(@food).to be_valid
    end

    it 'should validate presence of name' do
      @food.name = 'aa'
      expect(@food).to_not be_valid
      @food.name = nil
      expect(@food).to_not be_valid
    end

    it 'should validate length of name' do
      @food.name = 'a' * 51
      expect(@food).to_not be_valid
    end

    it 'should validate presence of measurement_unit' do
      @food.measurement_unit = nil
      expect(@food).to_not be_valid
    end

    it 'should validate presence of price' do
      @food.price = nil
      expect(@food).to_not be_valid
    end
  end
end
