ActionController::Routing::Routes.draw do |map| 
 
  #, :has_many => [:education_histories,:work_histories,:tools,:generals,:languages]

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end      

  map.namespace :user do |user|    
    user.resources :account, :collection => [:changepassword]
    user.resources :projects,:resumes,:messages,:pfiles,:offers
  end
  
  map.namespace :admin do |admin|    
    admin.resources :users,:report,:languages,:tools,:temps
  end

  map.resources :administrasi,:main
  
  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "main", :action => "index"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources
  
  map.register 'register',
    :controller => "administrasi", :action => "register"
    
  map.login 'login',
    :controller => "administrasi", :action => "login"
    
  map.logout 'logout',
    :controller => "administrasi", :action => "logout"  
  
  map.forgot_pass 'forgot',
    :controller => "administrasi", :action => "forgot" 
  
  map.verified_user 'verify',
    :controller => "administrasi", :action => "verify"
    
  map.user_page 'user/',
    :controller => "user",:action=> "index"    
  
  map.admin_page 'admin/',
    :controller => "admin/temps"
  
  map.search 'advance_search',
    :controller => "main",:action=> "search"
  
  map.connect ':controller/:action'
  map.connect '/:action/', :controller => "user" 

end
