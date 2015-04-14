Rails.application.routes.draw do
  devise_for :users, controllers: { 
    registrations: "registrations" 
    }
  devise_scope :user do
    get '/' => 'static_pages#home'
    get '/getting_started' => 'static_pages#getting_started'
  end
  
  root 'static_pages#home'
  
  resources :users
  resources :events do
    resources :comments
  end
  get 'events/:tag', to: 'event#index'
  get 'users/:tag', to: 'users#index'
  resources :attendances, only: [:create, :destroy]
  resources :friendship_requests, only: [:create, :update, :destroy, :index]
  resources :invitations, only: [:new, :create]
end
