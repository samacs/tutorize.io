require 'capybara/rspec'
require 'selenium/webdriver'
require 'capybara-screenshot/rspec'

Capybara.server_host = '0.0.0.0'
Capybara.server_port = 3100
Capybara.app_host = "http://#{ENV.fetch('HOSTNAME')}:#{Capybara.server_port}"

Capybara.register_driver :selenium_chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new(
    args: %w[headless disable-gpu window-size=1400,1400 disable-dev-shm-usage]
  )

  Capybara::Selenium::Driver.new(app, browser: :remote,
                                      options: options,
                                      url: 'http://tutorize-selenium:4444')
end

Capybara.javascript_driver = :selenium_chrome_headless

# RSpec.configure do |config|
#   config.before(:each, js: true, type: :system) do
#     # driven_by :selenium, using: :chrome, screen_size: [1400, 1400], options: { browser: :remote, url: 'http://tutorize-selenium:4444' }
#   end
# end

# if ENV['LAUNCH_BROWSER']
#   # To test with browser opened in VNC screen sharing window
#   Capybara.configure do |config|
#     config.server_host = 'localhost'
#     config.server_port = 3100
#     config.javascript_driver = :selenium_chrome
#   end

#   Capybara.register_driver :selenium_chrome do |app|
#     Capybara::Selenium::Driver.new(
#       app,
#       browser: :remote,
#       capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
#         chromeOptions: {
#           args: [
#             'window-size=1024,768'
#           ]
#         }
#       ),
#       url: 'http://tutorize-selenium:4444/wd/hub'
#     )
#   end
# else
#   # To test with headless browser inside web container
#   Capybara.server = :puma, { Silent: true }

#   Capybara.register_driver :chrome_headless do |app|
#     options = ::Selenium::WebDriver::Chrome::Options.new

#     options.add_argument('--headless')
#     options.add_argument('--no-sandbox')
#     options.add_argument('--disable-dev-shm-usage')
#     options.add_argument('--window-size=1400,1400')

#     Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
#   end

#   Capybara.javascript_driver = :chrome_headless
# end

# Capybara.server = :puma, { Silent: true }

# Capybara.register_driver :chrome_headless do |app|
#   options = ::Selenium::WebDriver::Chrome::Options.new

#   options.add_argument('--headless')
#   options.add_argument('--no-sandbox')
#   options.add_argument('--disable-dev-shm-usage')
#   options.add_argument('--window-size=1400,1400')

#   Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
# end

# Capybara.javascript_driver = :chrome_headless
