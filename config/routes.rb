Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get "/teams", to: "teams#index"
  post "/teams", to: "teams#create"
  get "/teams/new", to: "teams#new"
  get "/teams/:id", to: "teams#show"
  get "/teams/:id/players", to: "teams#players"


  get "/players", to: "players#index"
  get "/players/:id", to: "players#show"
end
