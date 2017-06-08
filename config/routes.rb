Rails.application.routes.draw do
  resource :login, only: [] do
    get "/", to: "logins#index"
    post "/", to: "logins#login", as: "login"
    get "logout"
    get "reset_password"
  end

  resource :faction, only: [] do
    get "/", to: "factions#index"
  end

  root to: "factions#index"
end
