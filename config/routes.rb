Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get 'users/sign_out', to: 'devise/sessions#destroy'
  end

  # Commented to prevent defaulting to sign in view to check if signed in or not
  devise_scope :user do
    root "devise/sessions#new"
  end

  resources :foods, except: [:update]

  resources :users

  get "/shopping_lists", to: "shopping_lists#index", as: "shopping_lists"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

end
