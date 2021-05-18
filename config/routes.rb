Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :comments, only: [:create]
    resources :approvals, only: [:create, :destroy]
    resources :rejects, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :destroy]
end
