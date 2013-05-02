TwitterApp::Application.routes.draw do

  authenticated :user do
    root :to => 'tweets#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :tweets
end