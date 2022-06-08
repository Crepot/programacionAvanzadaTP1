Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :candidates
  resources :companies do
    resources :aplications
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
