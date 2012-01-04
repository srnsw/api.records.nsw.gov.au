Collection::Application.routes.draw do

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  # match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  # match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  # resources :products

  # Sample resource route with options:
  # resources :products do
  # member do
  # get 'short'
  # post 'toggle'
  # end
  #
  # collection do
  # get 'sold'
  # end
  # end

  # Sample resource route with sub-resources:
  # resources :products do
  # resources :comments, :sales
  # resource :seller
  # end

  # Sample resource route with more complex sub-resources
  # resources :products do
  # resources :comments
  # resources :sales do
  # get 'recent', :on => :collection
  # end
  # end

  # Sample resource route within a namespace:
  # namespace :admin do
  # # Directs /admin/products/* to Admin::ProductsController
  # # (app/controllers/admin/products_controller.rb)
  # resources :products
  # end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
  root :to => "search#index"
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  match 'unapi' => 'unapi#index'
  match 'oai' => 'oai#index'
  match 'search' => 'search#show'
  match 'opensearch' => 'opensearch#index'
  match 'usage' => 'usage#index' #developer documentation
 
  #for authentication
  devise_for :users
  resources :users, :only => [:index, :show]
  resources :token_authentications, :only => [:create, :destroy]
  resources :tags, :only => [:index, :show, :destroy]
  resources :flickr, :only => [:index]
  
  resources :accessdirections, :only => [:index, :show] do
    collection do
      get 'search'
    end
  end
  
  resources :activities, :only => [:index, :show, :create] do
    member do
      get 'functions'
      get 'series'
      get 'tags'
      get 'comments'
      post 'create'
    end
  end
  
  resources :agencies, :only => [:index, :show, :create] do
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
      get 'tags'
      get 'comments'
      post 'create'
    end
  end
  
  resources :functions, :only => [:index, :show, :create] do
    member do
      get 'activities'
      get 'agencies'
      get 'persons'
      get 'tags'
      get 'comments'
      post 'create'
    end
  end
  
  resources :items, :only => [:index, :show, :create] do
		member do
			get 'agencies'
			get 'persons'
      	get 'tags'
      	get 'comments'
			post 'create'
		end
	end
  
  resources :ministries, :only => [:index, :show, :create] do
    member do
      get 'portfolios'
      get 'tags'
      get 'comments'
      post 'create'
    end
  end
  
  resources :organisations, :only => [:index, :show, :create] do
    member do
      get 'preceding'
      get 'succeeding'
      get 'agencies'
      get 'tags'
      get 'comments'
      post 'create'
    end
  end
  
  resources :persons, :only => [:index, :show, :create] do
    member do
      get 'ministries'
      get 'portfolios'
      get 'functions'
      get 'agencies'
      get 'series'
      get 'tags'
      get 'comments'
      post 'create'
    end
  end
  
  resources :portfolios, :only => [:index, :show, :create] do
    member do
      get 'ministries'
      get 'agencies'
      get 'persons'
      get 'preceding'
      get 'succeeding'
      get 'tags'
      get 'comments'
      post 'create'
    end
  end

  resources :series, :only => [:index, :show, :create] do
    member do
      get 'items'
      get 'agencies_creating'
      get 'agencies_controlling'
      get 'preceding'
      get 'succeeding'
      get 'related'
      get 'activities'
      get 'persons'
	  get 'controlling'
	  get 'controlled'
      get 'tags'
      get 'comments'
	  post 'create'
    end
  end
end
