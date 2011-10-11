EDAndTD::Application.routes.draw do
  resources :posts 
 # get "home/index"
  resources :post_types , :usertypes
	match '/users/update_password/:perishable_token' => "users#update_password"
  match '/users/:user_id/comments/:comment_id/comment_status_like'=>"comments#comment_status_like" , :via => "get"
  match '/users/:user_id/comments/:comment_id/ajax_comment_status_like'=>"comments#ajax_comment_status_like" , :via => "get"
  match '/users/:user_id/comments/:comment_id/comment_status_unlike'=>"comments#comment_status_unlike" , :via => "get" 
  
  resources :users do
     resources :photo_upload 
  
   collection do 
     get 'forgot_password'
     post 'send_reset_password_link'
     put 'update_password_submit'
     get 'timeis'
     get 'database_value'
     post 'database_value_create'
     post 'is_user_exists'
     #put 'update_password' 
    #match 'update_password' => 'users#update_password', :as => :update_password, :via => :perishable_token
   end
   member do
    get 'edit_password'
    put 'change_password'
   end
     resources :posts  do
     collection do
      post 'search'
      post 'ajax_search'
      get 'post_sort'
 		  end
      member do
        get 'post_status_like'
        get 'post_status_unlike'
        get  'find_status'
        get  'ajax_post_status_like_unlike'
       end
      resources :comments  
      
      
    end
   end
   
  resources  :user_sessions 
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout 

 
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => "user_sessions#new"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
