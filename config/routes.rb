Rails.application.routes.draw do
  root 'sessions#new'

  resources :sessions, only: [:new, :create, :destroy]
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :tracks, only: [:index, :destroy]
end
