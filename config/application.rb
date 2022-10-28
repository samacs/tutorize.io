require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_mailbox/engine'
require 'action_text/engine'
require 'action_view/railtie'
require 'action_cable/engine'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tutorize
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Don't generate system test files.
    config.generators do |g|
      g.system_tests = nil
      g.template_engine :slim
      g.test_framework :rspec
    end

    host = ENV.fetch('HOST', 'tutorize.io.local')
    port = ENV.fetch('PORT', 3000).to_i

    config.hosts << host

    config.force_ssl = true

    config.redis_config = {
      url: ENV.fetch('REDIS_URL', 'redis://:tutorize@tutorize-redis:6379/0'),
      driver: :hiredis
    }

    config.active_job.queue_adapter = :sidekiq
    config.action_mailer.deliver_later_queue_name = :mailers

    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.{rb,ya?ml}')]

    config.default_url_options = { host: host, port: port }
  end
end
