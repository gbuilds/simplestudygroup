Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  resources :users
  resources :events do
    resources :comments
  end
  get 'events/:tag', to: 'event#index'
  get 'users/:tag', to: 'users#index'
  resources :attendances, only: [:create, :destroy]
end
