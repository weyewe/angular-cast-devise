AngularCasts::Application.routes.draw do
  # get "home/index"
  
  root to: 'home#index'
  get '/episodes' => 'screencasts#index', format: 'json'
  get '/episodes/:id' => 'screencasts#show', format: 'json'
  
  get '/sub_reddits' => 'sub_reddits#index', format: 'json'
  
  match 'extract_images' => 'home#extract_images', :as => :extract_images
  
  resources :sub_reddits 
  

  # scope :api do
  #   get "/screencasts(.:format)" => "screencasts#index"
  #   get "/screencasts/:id(.:format)" => "screencasts#show"
  # end
end
