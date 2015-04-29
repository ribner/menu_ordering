Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  resources :shops, only: [:new, :create, :show, :index] do
    resources :items, only: [:import, :index, :new] do
      collection { post :import }
    end
    resources :orders, only: [:show, :edit, :create]
    resources :orderjoins, only: [:create, :show, :destroy]
  end

  namespace :admin do
    resources :shops, only: [:show, :edit, :update, :destroy] do
      resources :orders, only: [:index, :destroy, :edit]
      resources :items
      resources :charts, only: [:index]
      resources :barcharts, only: [:index]
    end
  end
end

