require_relative 'support'

# rubocop:disable Style/MixinUsage
extend FactoryBot::Syntax::Methods
extend Support
# rubocop:enable Style/MixinUsage

DatabaseCleaner.clean_with :truncation
