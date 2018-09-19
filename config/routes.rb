Rails.application.routes.draw do

  devise_for :users

  resources :users, only: [:index, :show, :update]
  resources :charitable_organizations do
    get :drafts, on: :collection
    post :archive, on: :member
  end
  resources :distribution_points do
    get :drafts, on: :collection
    get :outdated, on: :collection
    get :archive, on: :member
  end
  resources :shelters do
    get :drafts, on: :collection
    get :outdated, on: :collection
    post :archive, on: :member
  end
  resources :needs do
    get :drafts, on: :collection
    post :archive, on: :member
  end
  resources :drafts, only: [:show, :destroy] do
    post :accept, on: :member
  end
  resources :amazon_products, except: [:new, :create, :destroy]
  namespace :connect do
    resources :markers
  end

  root to: "splash#index"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      resources :needs, only: %i[index create]

      resources :shelters, only: [:index, :outdated]
      get "/shelters" => 'shelters#index'
      get "/shelters/outdated" => 'shelters#outdated'
      get "/distribution_points" => 'distribution_points#index'
      get "/distribution_points/outdated" => 'distribution_points#outdated'
      get "/products" => 'amazon_products#index'
      get "/charitable_organizations" => 'charitable_organizations#index'

      namespace :connect do
        resources :markers, only: [:create, :index, :update]
        resources :categories, only: [:index]
      end
    end
  end

  resources :pages, only: [:index, :edit, :update, :destroy]

  # API JSON v2
  namespace :api, defaults: { format: :json } do
    namespace :v2 do
      get "/routes" => 'locations#routes'
      get "/:organization/:legacy_table_name" => 'locations#index', as: "api_locations"
      get "/:organization/:legacy_table_name/help" => 'locations#help', as: "api_locations_help"
    end
  end
  # HTML Pages v2 Locations
  get  ":organization/:legacy_table_name", to: "locations#index", as: "locations"
  post ":organization/:legacy_table_name", to: "locations#create"
  get  ":organization/:legacy_table_name/new", to: "locations#new", as: "new_location"
  get  ":organization/:legacy_table_name/drafts", to: "locations#drafts", as: "drafts_locations"
  get  ":organization/:legacy_table_name/:id/edit", to: "locations#edit", as: "edit_location"
  post ":organization/:legacy_table_name/:id/archive", to: "locations#archive", as: "archive_location"
  get  ":organization/:legacy_table_name/:id", to: "locations#show", as: "location"
  put  ":organization/:legacy_table_name/:id", to: "locations#update"
  # HTML Pages v2 Location Drafts
  post ":organization/:legacy_table_name/drafts/:id/accept", to: "location_drafts#accept", as: "accept_location_draft"
  get  ":organization/:legacy_table_name/drafts/:id", to: "location_drafts#show", as: "location_draft"
  delete ":organization/:legacy_table_name/drafts/:id", to: "location_drafts#destroy"
  # HTML Pages v2 Organizations
  get  ":organization", to: "organizations#show", as: "organization"


end
