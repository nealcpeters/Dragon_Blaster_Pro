DragonBlaster::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  resources :sessions
  resources :users do
    resources :heros
    resources :maps do
      resources :rooms
    end
  end

  resources :games

  post '/games/:id/input', to: 'games#input'

  get '/all_games/:user_id', to: 'games#all', as: 'all_games'

  get '/game/new/:map_id', to: 'games#launch', as: "games_launch"


end
