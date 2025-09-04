Rails.application.routes.draw do
  resources :projects do
    member do
      get "variables"
    end
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

  resources :m_variables
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    match ":project/*apiurl", to: "calls#handle_call", via: :all
  end

  namespace :admin do
    namespace :api do
      match "info/:project/*apiurl", to: "info#get_info", via: :get
      match "project/:project_id/variables", to: "m_variables#set_project_variable", via: :post
      match "endpoint/:endpoint_id/variables", to: "m_variables#set_endpoint_variable", via: :post
      match "project/:project_id/variables/:name", to: "m_variables#delete_project_variable", via: :delete
      match "endpoint/:endpoint_id/variables/:name", to: "m_variables#delete_endpoint_variable", via: :delete
    end
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
