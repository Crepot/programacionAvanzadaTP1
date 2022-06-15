Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do #Esto es por conveción 
    namespace :v1 do #Indico la Vesrion 1 de mi api

      resources :players
      resources :table do
        #resources :positions, only: [:show]
        resources :positions, only: [:index]
        resources :players, to: 'players#assigned' #MAL
      end
      resources :positions
      #resources :positions, except: [:update] 
      # Defines the root path route ("/")
      # root "articles#index"
      post 'authenticate', to: 'authentication#create'
    end
  end
end

