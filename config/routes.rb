Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      
      resources :posts, only: [:show, :create, :update, :destroy] do 
        post '/posts/:id/like', to: 'comments#like'
        delete '/posts/:id/unlike', to: 'comments#unlike'
        resources :comments, only: [:show, :create, :update, :destroy]
        post '/comments/:id/like', to: 'comments#like'
        delete '/comments/:id/unlike', to: 'comments#unlike'
      end

    end
  end
end
