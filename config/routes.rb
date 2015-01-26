Rails.application.routes.draw do
  resource  :dashboard
  resources :applications do
    resources :steps
  end
  resources :people
  resources :home, only: [:index]

  root to: "home#index"
  get "/login" => redirect("/auth/github"), as: :login

  get "/auth/github/callback", to: "sessions#create"
  delete "/logout" => "sessions#destroy", as: :logout

  get "/application/submission_confirmation", to: "applications#submission_confirmation"
end
