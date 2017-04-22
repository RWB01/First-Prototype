Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'users/index' => 'users#index'
  resources :users

  root 'users#index'
end
