Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/teams/", to: "teams#index"
  post "/teams/", to: "teams#create"
  delete "/teams/:id", to: "teams#destroy"
  get "/teams/new", to: "teams#new"
  get "/teams/:id", to: "teams#show"
  patch "teams/:id", to: "teams#update"
  get "/teams/:id/edit", to: "teams#edit"
  # teamsplayerscontroller
  get "/teams/:id/players", to: "teams#players"  # handles sorted and filtered
  get "/teams/:id/players/new", to: "teams#create_player"
  post "/teams/:id/players", to: "teams#add_new_player"

  get "/players/", to: "players#index"
  delete "/players.:id", to: "players#destroy"
  get "/players/:id", to: "players#show"
  patch "/players/:id", to: "players#update"
  get "/players/:id/edit", to: "players#edit"
end
