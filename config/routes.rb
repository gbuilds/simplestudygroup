Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root 'static_pages#home'
  get 'about' => 'static_pages#about'
  resources :users
  resources :events do
    resources :comments
  end
  get 'events/:tag', to: 'event#index'
  get 'users/:tag', to: 'users#index'
  resources :attendances, only: [:create, :destroy]
  resources :friendship_requests, only: [:create, :update, :destroy]
end
