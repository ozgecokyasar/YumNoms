Rails.application.routes.draw do

  namespace :admin do
    resources :dashboard, only: :index
  end


resources :sessions, only: [:new, :create] do
  delete :destroy, on: :collection
end
resources :users, only: [:new, :create, :edit, :update]

root "welcome#index"
resources :welcome

resources :posts  do
  resources :favourites, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
end

resources :tags


end
