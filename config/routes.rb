Rails.application.routes.draw do

  root to: redirect("https://github.com/sketch-city/harvey-api")
  namespace :api do
    namespace :v1 do

      post "/google-sheet-update" => "hooks#sheet_update"

      get "/needs" => 'needs#index'
      get "/shelters" => 'shelters#index'
    end
  end
end
