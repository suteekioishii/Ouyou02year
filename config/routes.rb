Rails.application.routes.draw do
  root "top#index"

  resources :reservations 

  resources :shifts
  resources :customers do
    get "login", on: :collection
  end

  resources :salons, only:[:index, :show] do
    #いいね機能のアクション
    patch "like", "unlike", on: :member
    get "voted", on: :collection
    #ネスト
    resources :reservations, only: [:new,:create]
  end

  #ログイン処理
  resource :session, only: [:show,:create,:destroy]

  #パスワード
  resource :password, only: [:show,:edit,:update]

  #管理者向け
  namespace :admin do
    root "top#index"
    resources :salons
    resource :session, only: [:show, :create, :update,:destroy]
    resource :password, only: [:show,:edit,:update]
    resources :administrators, only: [:show, :update, :edit]
  end

  #オーナー
  namespace :owner do
    root"top#index"
    resources :stylists do
      resources :shifts, only: [:new, :edit, :create, :update, :destroy] do
        get "destroy_index", on: :collection
      end
    end
    resource :session, only: [:show, :create, :update,:destroy]
    resource :password, only: [:show,:edit,:update]
    resources :owners, only: [:show, :update, :edit]
  end
end
