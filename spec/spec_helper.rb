ENV['RACK_ENV'] = 'test'

require './app/app'
require 'capybara/rspec'
require 'database_cleaner'
require './app/data_mapper_setup'
require 'simplecov'
require 'simplecov-console'
require 'web_helper.rb'

Capybara.app = Chitter

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console,
  # Want a nice code coverage website? Uncomment this next line!
  SimpleCov::Formatter::HTMLFormatter
  ])
SimpleCov.start

RSpec.configure do |config|
  # Everything in this block runs once before all the tests run
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  # Everything in this block runs once before each individual test
  config.before(:each) do
    DatabaseCleaner.start
  end

  # Everything in this block runs once after each individual test
  config.after(:each) do
    DatabaseCleaner.clean
  end
end
