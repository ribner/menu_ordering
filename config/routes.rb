Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  resources :shops do
    resources :items do
      collection { post :import }
    end
    resources :orders
    resources :orderjoins
  end



  namespace :admin do
    resources :shops do
      resources :orders
    end
  end
end
