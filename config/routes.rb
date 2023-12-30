Rails.application.routes.draw do
  root "top#index"

  resources :reservations
  resources :salons do
    #ネスト
    resources :customers
  end
end
