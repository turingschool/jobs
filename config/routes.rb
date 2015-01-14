Rails.application.routes.draw do
  resource  :dashboard
  resources :applications do
    resources :steps
  end
  resources :people
  resources :home, only: [:index]

  root to: "home#index"
end
