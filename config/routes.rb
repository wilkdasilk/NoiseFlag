Rails.application.routes.draw do

  root to: "flags#index"
  get "/welcome", to: "splash#index", as: "splash"

  # from https://www.sitepoint.com/introduction-to-using-jwt-in-rails/
  post 'auth_user' => 'authentication#authenticate_user'

  namespace :api do
    get "/tracks", to: "tracks#search", as: "tracks", :defaults => {:format => 'json'}
  end

  resources :flags
  post "flags/:flag_id/entries", to: "entries#create", as: "entries", :defaults => {:format => 'json'}


  # User routes
  # Why custom registrations? To handle additional user fields: http://jacopretorius.net/2014/03/adding-custom-fields-to-your-devise-user-model-in-rails-4.html
  devise_for :users, :controllers => { registrations: 'registrations' }
  get "/users/:id", to: "users#show", as: "user"

  get 'hello_world', to: 'hello_world#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
