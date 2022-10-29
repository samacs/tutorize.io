RSpec.configure do |config|
  config.include ActionView::Helpers::UrlHelper
  config.include Rails.application.routes.url_helpers
end
