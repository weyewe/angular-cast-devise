AngularCasts::Application.routes.draw do
  devise_for :users

  # get "home/index"
  
  root to: 'home#index'
  
  match 'authenticate_auth_token' => 'sessions#authenticate_auth_token', :as => :authenticate_auth_token
  
  
  get '/episodes' => 'screencasts#index', format: 'json'
  get '/episodes/:id' => 'screencasts#show', format: 'json'
  
  get '/sub_reddits' => 'sub_reddits#index', format: 'json'
  
  match 'extract_images' => 'home#extract_images', :as => :extract_images
  
  resources :sub_reddits 
  
  namespace :api do
    devise_for :users
  end
  

  # scope :api do
  #   get "/screencasts(.:format)" => "screencasts#index"
  #   get "/screencasts/:id(.:format)" => "screencasts#show"
  # end
end
