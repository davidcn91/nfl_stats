Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'users'}

  resources :teams

  root 'teams#index'
end
