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

  get '/all_maps', to: 'maps#all'


end
