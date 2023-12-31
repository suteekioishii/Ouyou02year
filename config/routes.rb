Rails.application.routes.draw do
  root "top#index"

  resources :reservations
  resources :customers do
    get "login", on: :collection
    resources :salons
  end
  resources :salons do
    #ネスト
    resources :customers
  end
  resource :session
end
