Rails.application.routes.draw do
  
  # Landing paths
  get '/' => 'landing#index'
  get '/main' => 'main#index'
  get 'main/sort' => 'main#update'

  post 'main/sort' => 'main#update', as: 'sort_users'
  post 'main/filter' => 'main#filter', as: 'filter_users'

  # Work on -- Hmm I think this was for the new page in mobile
  # get '/search' => 'main#search'
  
  # User paths
  get '/signup' => 'users#new'
  post '/signup' => 'users#create'
  get '/:token/confirm_email/', :to => "users#confirm_email", as: 'confirm_email'
  
  # Session paths
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
  
  # Work on -- Hmm may not need these if going through the settings controller?
  get '/login/password_reset' => 'passwords#new', as: 'request_new_password'
  post '/new_password' => 'passwords#create'
  get '/:token/new_password/' => 'passwords#edit', as: 'new_password_form'
  post '/update/:id' => 'passwords#update'
  patch '/update/:id' => 'passwords#update', as: 'passwords_update'



  # mount ActionCable.server => '/cable'
  # Work on -- searches not done
  #searching
  get '/search/' => 'search#new', as: 'search'
  
  # Conversations Paths
  get ':user_name/messages' => 'conversations#index', as: 'messages'
  get ':user_name/messages' => 'conversations#create', as: 'create_room'

  get '/messages/r/:id' => 'conversations#show', as: 'room'

  # Messages Paths
  post '/messages/r/:id' => 'messages#create', as: 'direct_message'

  # resources :messages
  
  
  # Profile paths
  get '/:user_name/' => 'profiles#show', as: 'profile'
  get '/:user_name/create_profile' => 'profiles#create'
  post '/:user_name/create_profile' => 'profiles#create'
  get '/:user_name/profile/edit' => 'profiles#edit', as: 'edit_profile'
  post '/:user_name/profile/edit' => 'profiles#update', as: 'update_profile'
  post '/:user_name/profile/edit_photos/' => 'profiles#edit_photos', as: 'edit_photos'
  delete '/:user_name/profile/photo_delete/:id' => 'profiles#delete_photo', as: 'delete_photo'
  post '/:user_name/profile_flagged' => 'profiles#flag', as: 'flag_profile'

  # Settings path
  get ':user_name/edit' => 'settings#edit', as: 'settings'
  post ':user_name/edit' => 'settings#update', as: 'settings_update'
  # post ':user_name/edit' => 'settings#update_password', as: 'settings_pass_update'

  # partials for forms --> Settings
  get '/:user_name/edit_user' => 'settings#edit_user', as: 'edit_user'
  post '/:user_name/edit_user' => 'settings#update'
  get '/:user_name/edit_password' => 'settings#edit_password', as: 'edit_password'
  patch '/:user_name/edit_password' => 'settings#update_password', as: 'update_password'
  get '/:user_name/views_and_likes' => 'settings#activity', as: 'views_and_likes'
  
  # Likes path
  post '/:profile_id/like', to: 'likes#create', as: 'like'
  delete '/:profile_id/unlike', to: 'likes#destory', as: 'unlike'

  # Work on -- Havent finished the blocking feature, literally at all
  # Blocks path
  post '/:profile_id/block', to: 'blocks#create', as: 'block'
  delete '/:profile_id/unblock', to: 'blocks#destroy', as: 'unblock'
  
  

  
  
  # match 'like', to: 'likes#create', via: :post
  # match 'unlike', to: 'likes#destory', via: :delete

  
  # get '/users' => 'users#new'
  # post '/create_profile' => 'profiles#create', as: 'create_profile'
  # post '/profile' => 'profiles#update'
  # root to: 'main#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
