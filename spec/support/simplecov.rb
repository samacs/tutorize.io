require 'simplecov'
require 'simplecov-console'
require 'simplecov-lcov'

if ENV.fetch('CI', false)
  SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
else
  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
    [
      SimpleCov::Formatter::HTMLFormatter,
      SimpleCov::Formatter::Console,
      SimpleCov::Formatter::LcovFormatter
    ]
  )
end

SimpleCov.minimum_coverage 90
SimpleCov.start 'rails' do
  add_group 'Actions', 'app/actions'
  add_group 'Concerns', 'app/controllers/concerns'
  add_group 'Constraints', 'app/constraints'
  add_group 'Controllers', 'app/controllers'
  add_group 'Decorators', 'app/decorators'
  add_group 'Helpers', 'app/helpers'
  add_group 'Libraries', 'app/lib'
  add_group 'Mailers', 'app/mailers'
  add_group 'Policies', 'app/policies'
  add_group 'Services', 'app/services'
  add_group 'Tasks', 'lib/tasks'
  add_group 'Views', 'app/views'
  add_group 'Workers', 'app/workers'
end
