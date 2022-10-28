source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', require: false
gem 'bootstrap'
gem 'draper'
gem 'hiredis'
gem 'image_processing', '~> 1.2'
gem 'importmap-rails'
gem 'jbuilder'
gem 'kredis'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.4'
gem 'rails-settings-cached'
gem 'redis', '~> 4.0'
gem 'sassc-rails'
gem 'sidekiq', '<7'
gem 'sidekiq-cron'
gem 'slim'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'storext', github: 'erikaxel/storext'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'letter_opener_web'
  gem 'pry'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'rubocop'
  gem 'rubocop-faker', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'slim_lint'
  gem 'solargraph-rails'
end

group :development do
  gem 'html2slim'
  gem 'htmlbeautifier'
  gem 'rack-mini-profiler'
  gem 'ruby_parser'
  gem 'spring'
  gem 'steep'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'rspec-its'
  gem 'rspec-rails'
  gem 'rspec-retry'
  gem 'rspec-sidekiq'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  gem 'simplecov-lcov', require: false
  gem 'timecop'
end
