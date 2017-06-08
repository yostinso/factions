Rails.application.routes.draw do
  resource :login, only: [] do
    get "index"
    post "index", to: "login#login", as: "login"
    get "logout"
    get "reset_password"
  end

  get "factions/index"

  root to: "factions#index"
end
