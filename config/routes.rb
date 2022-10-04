Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => "homes#about"
  resources :books, only:[:index, :show, :edit, :update, :destroy, :create]
  resources :users, only:[:edit, :show, :index, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
