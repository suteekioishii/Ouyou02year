Rails.application.routes.draw do
  root "top#index"

  resources :reservations do
    resources :shifts
    resources :customers do
      get "login", on: :collection
    end
  end
  resources :shifts
  resources :customers do
    get "login", on: :collection
    resources :salons
  end
  resources :salons do
    #ネスト
    resources :customers
    resources :reservations
  end
  resource :session

  #管理者向け
  namespace :admin do
    root "top#index"
    resources :salon
  end

  #オーナー
  namespace :owner do
    root"top#index"
    resources :stylist
  end
end
