Rails.application.routes.draw do
  devise_for :users

  resources :users, only: [:index, :show, :update]
  resources :shelters do
    get :drafts, on: :collection
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

  root to: "shelters#index"
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      post "/google-sheet-update" => "hooks#sheet_update"

      get "/needs" => 'needs#index'
      get "/shelters" => 'shelters#index'
      get "/products" => 'amazon_products#index'

      namespace :connect do
        resources :markers, only: [:create, :index, :update]
        resources :categories, only: [:index]
      end
    end
  end
end
