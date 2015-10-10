Rails.application.routes.draw do
  devise_for :users
  resources :users, only: [:update]

  post :incoming, to: 'incoming#create'

  get 'about' => 'welcome#about'

  root to: 'welcome#index'
end