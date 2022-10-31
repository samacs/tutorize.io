require 'capybara/rspec'
require 'selenium/webdriver'
require 'capybara-screenshot/rspec'

def dockerized?
  File.exist?('/.dockerenv')
end

options = ::Selenium::WebDriver::Chrome::Options.new(
  args: %w[headless disable-gpu window-size=1400,1400 disable-dev-shm-usage]
)

if dockerized?
  Capybara.server_host = '0.0.0.0'
  Capybara.server_port = 3100
  Capybara.app_host = "http://#{ENV.fetch('HOSTNAME')}:#{Capybara.server_port}"

  Capybara.register_driver :selenium_chrome_headless do |app|
    Capybara::Selenium::Driver.new(app, browser: :remote,
                                        options:,
                                        url: 'http://tutorize-selenium:4444')
  end
else
  Capybara.server = :puma, { Silent: true }
  Capybara.server_host = ENV.fetch('HOST', 'tutorize.io.local')

  Capybara.register_driver :selenium_chrome_headless do |app|
    Capybara::Selenium::Driver.new(app, browser: :chrome,
                                        options:)
  end
end

Capybara.javascript_driver = :selenium_chrome_headless

Capybara::Screenshot.prune_strategy = :keep_last_run
