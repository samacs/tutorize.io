require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
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
