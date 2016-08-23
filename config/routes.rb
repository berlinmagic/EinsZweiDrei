Rails.application.routes.draw do
  
  
  
  scope :mgclang, module: :magic_locales do
    resources :locales do
      get "trigger/:state", action: :trigger, on: :member, as: :trigger
    end
    get "/" => "locales#index"
  end
  get "/change-locale/:locale", controller: "magic_locales/locales", action: :change_locale, as: :change_locale


  scope :mgca, module: :magic_addresses do
    resources :addresses, only: :index
    resources :countries, only: :index
    resources :states, only: :index
    resources :cities, only: :index
    resources :districts, only: :index
    resources :subdistricts, only: :index
    get "/" => "countries#index"
  end


  ###
  ### => Additional Routes injected with APP_Generator
  ###
  
  
  # => require 'sidekiq/web'
  
  resources :feedbacks,     only: :create
  resources :subscriptions, only: :create
  
  
  
  ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ######
  ## Admin
  ###### ###### ######
  scope :admin, module: :wizard, as: :admin do
    ## sidekiq if needed
    # => authenticate :user, lambda { |u| u.is_wizard? } do
    # =>   mount Sidekiq::Web => '/sidekiq'
    # => end
    ## resources
    
    resources :questions do
      post  :sort,          on: :collection
    end
    
    resources :users do
      member do
        get :make_admin
        get :remove_admin
      end
      collection do
        get "act_as/:uid", action: :act_as, as: :act_as
      end
    end
    resources :feedbacks
    resources :subscriptions
    ## additional
    get   "styles"          => "pages#styles",        as: :styles
    get   "verify/:that"    => "pages#verify",        as: :verify
    post  "verify_that"     => "pages#verify_that",   as: :verify_that
    ## admin-root
    root "pages#dashboard"
  end
  ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ######
  
  
  ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ######
  ## App (logged in)
  ###### ###### ######
  scope :app, module: :backend, as: :app do
    
    resources :questions do
      post  :sort,          on: :collection
      get   :build_samples, on: :collection
    end
    
    resources :settings, only: [:index, :create, :update] do
      get :defaults, on: :collection
    end
    
    ## users
    resources :users do
      member do
        get :dashboard
        get "edit/:step", action: :edit_step, as: :edit_step
        delete :delete_image
      end
    end
    ## app-root
    root "pages#dashboard"
  end
  ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ######
  
  FrontendController::PAGEZ.each do |pg|
    get "#{pg.dasherize}" => "frontend#show", page: pg, as: pg.to_sym
  end
  
  
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks", confirmations: "users/confirmations" }
  
  
  root 'frontend#start'
  
  get "/game" => "frontend#game", as: :game
  
  
  get "/sitemap", constraints: { format: /html|txt/ }, controller: :sitemap, action: :text
  get "/sitemap", constraints: { format: :xml },       controller: :sitemap, action: :xml
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
