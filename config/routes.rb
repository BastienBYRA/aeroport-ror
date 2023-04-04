Rails.application.routes.draw do
  devise_for :users
=begin
  resources :flights
=end
  resources :flights do
    get '/:page', action: :index, on: :collection
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "flights#index"
end
