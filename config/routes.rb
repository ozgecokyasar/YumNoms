Rails.application.routes.draw do

  get "/auth/twitter", as: :sign_in_with_twitter
get "/auth/:provider/callback", to: 'callbacks#index'

namespace :api, defaults: {format: :json } do
  namespace :v1 do
    resources :posts, only: [:index, :show, :create]
    resources :tokens, only: [:create]
  end
end


  namespace :admin do
    resources :dashboard, only: :index
  end



resource :session, only: [:new, :create, :destroy]
resources :users
resources :post_maps, only: [:index]

root "posts#index"


resources :posts  do
  resources :favourites, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]
end

resources :tags


end
