Twidder::Application.routes.draw do
  scope '(:locale)' do
    devise_for :users

    get "users/mine"
    resources :users, :only => [:index, :show, :destroy] do
      member do
        get :followees, :followers
      end
    end

    resources :following_items, only: [:create, :destroy]

    resources :microposts, only: [:index, :new, :create, :destroy]

    resources :microgroups do
      resources :microposts, only: [:create, :destroy]
    end

    resources :projects do
      resources :reviews, only: [:create, :destroy]
    end

    resources :reviews, only: [] do
    # resources :votes, only: [:create, :destroy]
      member do
        get :up, :down
      end
    end

    resources :posts do
      resources :comments
    end

    get "home/index"
    get "home/test"
    authenticated :user do
      root :to => 'home#index'
    end
    root :to => 'home#index'
  end

    # Starting from Rails 3.1, wildcard routes will always
    # match the optional format segment by default.
    # to enable paths match all the characters, we set
    #
    # :format => false
    #
    match 'projects/:id/:tree/*paths/:line' => 'projects#show', :as => :line_project, :constraints => { :tree => 'line' }, :format => false
    match 'projects/:id/:tree/*paths' => 'projects#show', :as => :blob_project, :constraints => { :tree => 'blob' }, :format => false
    match 'projects/:id/:tree(/*paths)' => 'projects#show', :as => :tree_project, :constraints => { :tree => 'tree' }, :format => false
  # match 'projects/:id/:tree/*paths' => 'projects#show', :as => :blob_project, :constraints => { :tree => 'blob' }, :via => :get, :format => false
  # match 'projects/:id/:tree(/*paths)' => 'projects#show', :as => :tree_project, :constraints => { :tree => 'tree' }, :via => [:get, :post, :delete], :format => false

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
