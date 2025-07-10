Rails.application.routes.draw do
  resources :projects do
    resources :endpoints, shallow: true do
      collection do
        get "fetch_path_params"
      end
      member do
        get "fetch_curl_code"
        get "variables"
      end
      resources :responses, shallow: true do
        resources :expressions, shallow: true
        resources :headers, shallow: true
      end
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    match ":project/*apiurl", to: "calls#handle_call", via: :all
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "projects#index"
end
