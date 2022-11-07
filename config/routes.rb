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

  get '/reset-password', to: 'password_resets#new'
  post '/reset-password', to: 'password_resets#create'
  get '/change-password', to: 'password_resets#edit'
  patch '/change-password', to: 'password_resets#update'

  get '/resend-confirmation', to: 'confirmations#new'
  post '/resend-confirmation', to: 'confirmations#create'

  get '/profile', to: 'profile#edit'
  patch '/profile', to: 'profile#update'

  get '/settings', to: 'settings#edit'
  patch '/settings', to: 'settings#update'

  resources :courses do
    resources :lessons do
      resources :enrollments
      resources :lectures
    end
  end
  resources :teachers

  # Authenticated routes
  scope constraints: SessionConstraint.new(&:present?), as: :authenticated do
    mount Sidekiq::Web, at: '/sidekiq' if Rails.env.production?

    root 'dashboard#index'
  end

  resources :my_courses, path: '/my-courses' do
    resources :lessons, controller: :my_lessons
  end
  resources :availabilities

  # System routes
  if Rails.env.development?
    mount Sidekiq::Web, at: '/sidekiq' if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
  end

  mount ActionCable.server, at: '/cable'

  # Defines the root path route ("/")
  root 'static_pages#show', page: 'home'

  # Catch-all route to render static pages
  get '/*page', to: 'static_pages#show', as: :static_pages, constraints: lambda { |req|
    req.fullpath !~ %r{^\assets|rails/.*}
  }
end
