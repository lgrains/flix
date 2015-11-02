Rails.application.routes.draw do
  resources :genres

  resources :users

  get 'signup' => 'users#new'

  root "movies#index"

  resources :movies do
    resources :reviews
    resources :favorites
  end

  resource :session

  get "sign_in" => "sessions#new"
end
