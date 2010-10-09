ENV['RAILS_ENV'] ||= 'test'
Bundler.require(:default, :test) if defined?(Bundler)
require 'spork'

Spork.prefork do
  require File.expand_path('../config/environment', File.dirname(__FILE__) )
  require 'rspec/rails'
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

  # rspec configuration
  Rspec.configure do |config|
    config.mock_with :rspec
#    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # db cleaner
    config.before(:suite) do
      DatabaseCleaner.orm = 'mongoid'
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.clean
    end
  end

#  Capybara.default_selector = :css
end

Spork.each_run do
  # clear screen
  print "\x1b[2J\x1b[H" ; $stdout.flush
end
