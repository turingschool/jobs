Rails.application.routes.draw do
  resource  :dashboard
  resources :applications do
    resources :steps
  end
  resources :people

  root :to => "dashboards#show"
  # root :to => ("/auth/github"), as: :login
  get "/login" => redirect("/auth/github"), as: :login

  get '/auth/github/callback', to: 'sessions#create'
  delete "/logout" => "sessions#destroy", as: :logout



end
