Rails.application.routes.draw do
  
  #landing paths
  get '/' => 'landing#index'
  get '/main' => 'main#index'
  # get '/search' => 'main#search'
  
  #user paths
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  #session paths
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  
  #searching
  get '/search/' => 'search#new', as: 'search'
  
  get '/messages' => 'conversations#index', as: 'messages'
  
  #profile paths
  get '/:user_name/' => 'profiles#show', as: 'profile'
  post '/:user_name/' => 'profiles#create'
  get '/:user_name/edit' => 'profiles#edit', as: 'edit_profile'
  # patch '/:id/edit' => 'profiles#update', as: 'patch_profile'
  post '/:user_name/edit' => 'profiles#update', as: 'update_profile'
  #partials for forms
  get '/:user_name/edit_user' => 'profiles#edit', as: 'edit_user'
  get '/:user_name/edit_password' => 'profiles#edit', as: 'edit_password'
  get '/:user_name/edit_user_profile' => 'profiles#edit', as: 'edit_user_profile'
  get '/:user_name/edit_photos' => 'profiles#edit', as: 'edit_photos'
  get '/:user_name/views_and_likes' => 'profiles#edit', as: 'views_and_likes'
  
  #likes path
  post '/:profile_id/like', to: 'likes#create', as: 'like'
  delete '/:profile_id/unlike', to: 'likes#destory', as: 'unlike'
  
  match 'unheart', to: 'hearts#unheart', via: :delete
  
  get '/new_password_form' => 'passwords#edit'
  get 'passwords/update'
  post 'passwords/update'
  get '/new_password' => 'passwords#new'
  post '/new_password' => 'passwords#create'
  
  
  # match 'like', to: 'likes#create', via: :post
  # match 'unlike', to: 'likes#destory', via: :delete

  
  # get '/users' => 'users#new'
  # post '/create_profile' => 'profiles#create', as: 'create_profile'
  # post '/profile' => 'profiles#update'
  # root to: 'main#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
