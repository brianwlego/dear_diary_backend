Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show] do
      get '/posts', to: 'users#posts'
      post '/follow', to: 'users#follow'
      post '/unfollow', to: 'users#unfollow'
      get '/followers', to: 'users#followers'
      get '/followings', to: 'users#followings'
      end
      
      post '/login', to: 'auth#create'
      get '/profile', to: 'users#profile'
      
      # CRUD Action for Posts
      resources :posts, only: [:show, :create, :update, :destroy, :index] do 
        post '/like', to: 'posts#like'
        delete '/unlike/:id', to: 'posts#unlike'
        # Nested CRUD action for Comments
        # ie. localhost:3000/posts/:id/comments/
        resources :comments, only: [:create, :update, :destroy]
        post '/comments/:id/like', to: 'comments#like'
        delete '/comments/:id/unlike/:id', to: 'comments#unlike'
      end

    end
  end
end
