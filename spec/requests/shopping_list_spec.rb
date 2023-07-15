require 'rails_helper'

RSpec.describe 'ShoppingLists', type: :request do
  include Devise::Test::IntegrationHelpers

  describe 'GET /index' do
    it 'returns http success' do
      @user = User.create(name: 'John', email: 'john@gmail.com', password: '123456', password_confirmation: '123456')

      login_as(@user, scope: :user)

      get '/shopping_lists'
      expect(response).to have_http_status(:success)
    end
  end
end
