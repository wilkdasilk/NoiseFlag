Rails.application.routes.draw do

  root to: "flags#index"
  get "/welcome", to: "splash#index", as: "splash"

  # from https://www.sitepoint.com/introduction-to-using-jwt-in-rails/
  post 'auth_user' => 'authentication#authenticate_user'

  namespace :api do
    get "/tracks", to: "tracks#search", as: "tracks", :defaults => {:format => 'json'}
  end

  resources :flags
  post "/flags/:flag_id/checkins", to: "checkins#create", as: "checkins"
  post "/flags/:flag_id/entries/:track_id", to: "entries#create", as: "entries"
  get "/flags/:flag_id/entries/new", to: "entries#new", as: "new_entry"
  delete "/entries/:id", to: "entries#destroy", as: "entry"
  put "/entries/:id/upvote", to: "entries#upvote", as: "upvote"
  put "/entries/:id/downvote", to: "entries#downvote", as: "downvote"
  put "/entries/:id/unvote", to: "entries#unvote", as: "unvote"

  # User routes
  # Why custom registrations? To handle additional user fields: http://jacopretorius.net/2014/03/adding-custom-fields-to-your-devise-user-model-in-rails-4.html
  devise_for :users, :controllers => { registrations: 'registrations', :omniauth_callbacks => "users/omniauth_callbacks" }
  get "/users/:id", to: "users#show", as: "user"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
