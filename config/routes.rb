Rails.application.routes.draw do

  
  
  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :dashboard

  resources :users do
    get :add_role, on: :member
    get :remove_role, on: :member
    get :add_discipline, on: :member
    get :remove_discipline, on: :member
  end

  resources :roles

  resources :disciplines, shallow: true do
    resources :themes
  end

  resources :themes, shallow: true do
    resources :algorithms
  end

  resources :algorithms do
    post :change_options, on: :member
  end

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
