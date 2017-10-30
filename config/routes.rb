Rails.application.routes.draw do

  
  
  resources :input_variable_values
  resources :tests
  resources :test_sessions



  devise_for :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :dashboard

  resources :users do
    get :add_role, on: :member
    get :remove_role, on: :member
    get :add_discipline, on: :member
    get :remove_discipline, on: :member
    get :add_group, on: :member
    get :remove_group, on: :member
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

  controller 'test' do
    get 'start/test' => :start
    post 'step/test' => :step
    get 'result/test' => :result
  end

  controller 'test_sessions' do
    post 'test_sessions/add_one_algorithm' => :add_one_algorithm
    post 'test_sessions/appoint_test_session' => :appoint_test_session
    post 'test_sessions/draw_students_forms' => :draw_students_forms
  end

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
