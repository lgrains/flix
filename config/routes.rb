Rails.application.routes.draw do

  resources :favorites

  resources :users

  get 'signup' => 'users#new'

  root "movies#index"
  resources :movies do
    resources :reviews
  end

  resource :session

  get "sign_in" => "sessions#new"
end
