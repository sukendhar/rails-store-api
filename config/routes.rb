Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  post "/signup", to: "authentication#signup"
  post "/login",  to: "authentication#login"

  namespace :api do
    namespace :v1 do
      resources :stores do
        get "items_count", on: :member
        resources :items, shallow: true do
          resources :ingredients, shallow: true
        end
      end
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "api/v1/stores#index"
end
