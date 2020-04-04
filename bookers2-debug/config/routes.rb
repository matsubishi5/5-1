Rails.application.routes.draw do
  root 'home#top'
  get 'home/about' => 'home#about'
  devise_for :users
  resources :users
  resources :books do
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end
  post 'follow/:id' => 'relationships#follow', as: 'follow'
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow'
  get 'users/following/:user_id' => 'users#following', as:'users_following'
  get 'users/follower/:user_id' => 'users#follower', as:'users_follower'
  get "search" => "search#search"
end
