Rails.application.routes.draw do

  namespace :admin do
    resources :dashboard, only: :index
  end


resource :session, only: [:new, :create, :destroy]
resources :users

root "posts#index"

resources :posts  do
  resources :comments, only: [:create, :destroy]

end



end
