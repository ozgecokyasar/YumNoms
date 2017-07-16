Rails.application.routes.draw do

  namespace :admin do
    resources :dashboard, only: :index
  end

resource :session, only: [:new, :create, :destroy]
resources :users, only: [:new, :create]

root "posts#index"
# get 'posts/:id', to: 'posts#show'
resources :posts do
  resources :comments, only: [:create, :destroy]
end



end
