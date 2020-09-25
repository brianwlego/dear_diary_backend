Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      
      # CRUD Action for Posts
      resources :posts, only: [:show, :create, :update, :destroy] do 
        post '/like', to: 'posts#like'
        delete '/unlike/:id', to: 'posts#unlike'
        # Nested CRUD action for Comments
        # ie. localhost:3000/posts/:id/comments/
        resources :comments, only: [:show, :create, :update, :destroy]
        post '/like', to: 'comments#like'
        delete '/unlike/:id', to: 'comments#unlike'
      end

    end
  end
end
