TwitterApp::Application.routes.draw do

  authenticated :user do
    root :to => 'tweets#show'
  end
  
  root :to => "home#index"
  devise_for :users
  resources :users do
  	member do
      get :following, :followers
    end
  end
  
  resources :tweets, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end