Rails.application.routes.draw do
  root 'homes#index'
  devise_for :users
  resources :shops do
    resources :items
    resources :orders
    resources :orderjoins
  end

end
