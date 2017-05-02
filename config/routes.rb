Rails.application.routes.draw do

  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :dashboard

  resources :users

  resources :community

  resources :groups

  resources :departments

  get '/communities', :to => 'community#index'

  authenticated :user do
    devise_scope :user do
      root to: 'dashboard#index'
    end
  end

  unauthenticated do
    devise_scope :user do
      root to: 'devise/sessions#new'
    end
  end
end
