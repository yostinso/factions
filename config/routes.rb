Rails.application.routes.draw do
  root to: "factions#index"
  resources :login
end
