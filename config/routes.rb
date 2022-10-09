Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => "homes#about"

  resources :books, only:[:index, :show, :edit, :update, :destroy, :create] do
    resource :favorites, only:[:create, :destroy]
    resources :comments, only:[:create, :destroy]
  end

  resources :users, only:[:edit, :show, :index, :update] do
    resource :relationships, only:[:create, :destroy]
    member do
      get :followings, :followers
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
