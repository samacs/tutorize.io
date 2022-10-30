require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  # Public routes
  get '/sign-in', to: 'sessions#new'
  post '/sign-in', to: 'sessions#create'

  delete '/sign-out', to: 'sessions#destroy'

  get '/sign-up', to: 'users#new'
  post '/sign-up', to: 'users#create'

  get '/confirm', to: 'users#confirm'

  resources :courses
  resources :teachers

  # Authenticated routes
  scope constraints: SessionConstraint.new(&:present?), as: :authenticated do
    mount Sidekiq::Web, at: '/sidekiq' if Rails.env.production?

    root 'dashboard#index'
  end

  # System routes
  if Rails.env.development?
    mount Sidekiq::Web, at: '/sidekiq' if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  mount ActionCable.server, at: '/cable'

  # Defines the root path route ("/")
  root 'static_pages#show', page: 'home'

  # Catch-all route to render static pages
  get '/*page', to: 'static_pages#show', as: :static_pages
end
