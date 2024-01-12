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
    #いいね機能のアクション
    patch "like", "unlike", on: :member
    get "voted", on: :collection
    #ネスト
    resources :customers
    resources :reservations
  end
  resource :session

  #管理者向け
  namespace :admin do
    root "top#index"
    resources :salons
    resource :session
  end

  #オーナー
  namespace :owner do
    root"top#index"
    resources :stylists
    resource :session
  end
end
