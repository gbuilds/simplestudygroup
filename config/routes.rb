Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#home'
  resources :users
  resources :events do
    resources :comments
  end
end
