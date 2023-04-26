Rails.application.routes.draw do

  ### USERS
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    unlocks: 'users/unlocks',
    confirmations: 'users/confirmations',
  }

  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end

  ### DASHBOARD
  scope controller: :dashboard do
    get '/dashboard', action: :index
  end

  ### STATIC
  get '/about', to: 'static#about'
  get '/pricing', to: 'static#pricing'

  ### MISC
  resources :webhooks, only: [:create]

  ### ROOT
  root "static#landing"
end
