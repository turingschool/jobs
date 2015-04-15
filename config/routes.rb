Rails.application.routes.draw do
  resource  :dashboard
  resources :applications do
    resources :steps
  end
  resources :people

  root :to => "dashboards#show"

  get "/auth/:provider/callback" => "sessions#create"
  get "/auth/failure" => "sessions#failure", as: :login_failure
  get '/login' => 'sessions#new', :as => :login
  get '/logout' => 'sessions#destroy', :as => :logout
end
