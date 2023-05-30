Rails.application.routes.draw do
  resources :reservations
  resources :seat_class_choices
  devise_for :users
  resources :flights

=begin
  resources :flights do
    get '/:page', action: :index, on: :collection
  end
=end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "flights#index"
end
