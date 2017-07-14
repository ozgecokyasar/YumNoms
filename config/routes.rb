Rails.application.routes.draw do

resource :session, only: [:new, :create, :destroy]
resources :users, only: [:new, :create]

root "posts#index"
# get 'posts/:id', to: 'posts#show'
resources :posts do
  resources :comments
end



end
