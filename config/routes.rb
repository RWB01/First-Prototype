Rails.application.routes.draw do
  get 'community/edit'

  get 'community/create'

  get 'community/update'

  get 'community/destroy'

  get 'dashboard/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get 'users/index' => 'users#index'
  resources :users

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
