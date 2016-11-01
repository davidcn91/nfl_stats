Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users'}

  resources :teams
  resources :games

  root 'teams#index'
end
