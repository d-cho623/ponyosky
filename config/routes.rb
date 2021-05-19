Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :comments, only: [:create]
    resources :approvals, only: [:create, :destroy]
    resources :rejects, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :destroy]
  post '/item/guest_sign_in', to: 'items#new_guest'
  post '/item/guest2_sign_in', to: 'items#new_guest2'
  post '/item/guest3_sign_in', to: 'items#new_guest3'
  post '/item/guest4_sign_in', to: 'items#new_guest4'
end
