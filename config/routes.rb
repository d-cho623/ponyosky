Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"
  resources :items do
    resources :approvals, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :destroy]

  # post "approvals/:item_id/create", to: "approvals#create", constraints: {item_id: /\d+/}, as: :approvals_create
  # post "approvals/:item_id/delete", to: "approvals#delete", constraints: {item_id: /\d+/}, as: :approvals_delete
end
