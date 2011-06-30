Collection::Application.routes.draw do
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
  # root :to => "welcome#index"
  root :to => "search#index"
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  match 'unapi' => 'unapi#index'
  match 'search' => 'search#show'
  match 'opensearch' => 'opensearch#index'
  match 'usage' => 'usage#index' #developer documentation
 
  resources :activities, :only => [:index, :show] do
	member do
	  get 'functions'
	  get 'series'
	end
  end
  
  resources :agencies, :only => [:index, :show] do
    member do
	  get 'preceding'
	  get 'succeeding'
	  get 'superior'
	  get 'subordinate'
	  get 'related'
	  get 'functions'
	  get 'organisations'
	  get 'persons'
	  get 'series_created'
	  get 'series_controlled'
	end
  end
  
  resources :functions, :only => [:index, :show] do
	member do
	  get 'activities'
	  get 'agencies'
	  get 'persons'
	end
  end
  
  resources :items, :only => [:index, :show]
  
  resources :ministries, :only => [:index, :show] do
	member do
	  get 'portfolios'
	end
  end
  
  resources :organisations, :only => [:index, :show] do
	  member do
		get 'preceding'
		get 'succeeding'
		get 'agencies'
	  end
  end
  
  resources :persons, :only => [:index, :show] do
    member do
	  get 'ministries'
      get 'portfolios'
	  get 'functions'
	  get 'agencies'
	  get 'series'
	end
  end
  
  resources :portfolios, :only => [:index, :show] do
    member do
		get 'ministries'
		get 'agencies'
		get 'persons'
		get 'preceding'
		get 'succeeding'
	end
  end
  resources :series, :only => [:index, :show] do
	member do
		get 'items'
		get 'agencies_creating'
		get 'agencies_controlling'
		get 'preceding'
		get 'succeeding'
		get 'related'
		get 'activities'
		get 'persons'
	end
  end
end
