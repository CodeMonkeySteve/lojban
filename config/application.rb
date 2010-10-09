require File.expand_path('../boot', __FILE__)
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'mongoid/railtie'

Bundler.require(:default, Rails.env) if defined?(Bundler)

# only use async Mongoid in production
require 'em-synchrony/mongoid'  if Rails.env == 'production'

module Lojban
  class Application < Rails::Application
    # Configure generators values. Many other options are available, be sure to check the documentation.
    config.generators do |g|
      g.orm :mongoid
      g.template_engine :haml

      g.integration_tool :rspec
      g.test_framework :rspec, :fixture => true, :views => true
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.active_support.deprecation = :stderr
  end
end
