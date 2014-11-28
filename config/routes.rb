Rails.application.routes.draw do
  resource  :dashboard
  resources :applications do
    resources :steps
  end
end
