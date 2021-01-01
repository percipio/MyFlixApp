Rails.application.routes.draw do

  resources :genres
  root "movies#index"

  get "movies/filter/:filter" => "movies#index", as: :filtered_movies
  
  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end

  resource :session, only: [:create, :new, :destroy]
  get "/signin" => "sessions#new"

  resources :users

end
