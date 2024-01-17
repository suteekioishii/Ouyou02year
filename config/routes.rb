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
    #ネスト^
    resources :customers
    resources :reservations
  end

  #ログイン処理
  resource :session

  #パスワード
  resource :password, only: [:show,:edit,:update]

  #管理者向け
  namespace :admin do
    root "top#index"
    resources :salons
    resource :session
    resource :password
    resources :administrators
  end

  #オーナー
  namespace :owner do
    root"top#index"
    resources :stylists do
      resources :shifts, only: [:new, :edit, :create, :update, :destroy] do
        get "destroy_index", on: :collection
      end
    end
    resource :session
    resource :password
    resources :owners
  end
end
