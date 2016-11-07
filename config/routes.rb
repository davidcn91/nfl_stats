Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users'}

  resources :teams
  resources :games do
    resources :stats
  end

  resources :seasons

  root 'teams#index'
end
