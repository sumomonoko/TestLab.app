Rails.application.routes.draw do

  scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    get 'ideal' => 'homes#ideal'

    resources :users, only: [:show, :edit, :update]
    resources :foods, only: [:index, :new, :show, :edit, :create, :update, :destroy]
    resources :relationships, only: [:followers, :following]
  end

  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :foods, only: [:index, :show, :destroy]
    resources :genre, only: [:index, :create, :destroy]
  end

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :user,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
