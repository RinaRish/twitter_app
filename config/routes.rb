TwitterApp::Application.routes.draw do

  authenticated :user do
    root :to => 'tweets#index'
  end
  
  root :to => "home#index"
  devise_for :users
  resources :users do
  	member do
      get :following, :followers
    end
  end
  resources :tweets
  resources :relationships, only: [:create, :destroy]
end