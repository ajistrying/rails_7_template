Rails.application.routes.draw do
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

  get 'static/landing'
  get 'static/about'
  get 'static/contact'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root "static#landing"
end
