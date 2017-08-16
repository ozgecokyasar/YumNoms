Rails.application.routes.draw do

  namespace :admin do
    resources :dashboard, only: :index
  end


resource :session, only: [:new, :create, :destroy]
resources :users

root "welcome#index"
resources :welcome

resources :posts  do
  resources :favourites, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
end

resources :tags


end
