source :gemcutter

# Core
gem 'bundler', '~> 1.0.0'
gem 'railties', '~> 3.0.0'
gem 'actionmailer', '~> 3.0.0'

# I/O
gem 'eventmachine', '= 0.12.10'   # must be same as Heroku
gem 'rack-fiber_pool',  :require => 'rack/fiber_pool'
gem 'em-synchrony', :require => [ 'em-synchrony', 'em-synchrony/em-http' ],
#  :git => 'git://github.com/igrigorik/em-synchrony.git'
  :git => 'git://github.com/CodeMonkeySteve/em-synchrony.git'
gem 'em-http-request' #, :git => 'git://github.com/igrigorik/em-http-request.git' #, :require => 'em-http'
gem 'thin'

# Database
gem 'mongo', '~> 1.0.8'
gem 'mongoid',  :git => 'git://github.com/CodeMonkeySteve/mongoid.git'  #'~> 2.0.0.beta'
gem 'bson',     '~> 1.0.7'  # must be same as bson_ext
gem 'bson_ext', '~> 1.0.7'  # must be same as bson

# Authentication
gem 'devise', :git => 'git://github.com/plataformatec/devise.git'  #'~> 1.1.2'
gem 'warden-openid'
gem 'rack-openid', :require => 'rack/openid'
gem 'openid_mongodb_store'

# Misc
gem 'haml', '~> 3.0.18'

if (ENV['RACK_ENV'] == 'production') || (ENV['USER'] =~ /^repo\d+$/)  # kludge to exclude on Heroku
  group :development do
    gem 'autotest-rails'
    gem 'rails3-generators'
    gem 'ruby-debug19',  :require => 'ruby-debug'
  end

  group :test do
    gem 'database_cleaner'
    gem 'factory_girl_rails', :git => 'git://github.com/CodeMonkeySteve/factory_girl_rails.git'
    gem 'factory_girl', :git => 'git://github.com/thoughtbot/factory_girl.git'
    gem 'rspec-rails', '~> 2.0.0.beta'
    gem 'spork'
    gem 'test_notifier'
    gem 'webrat'
  end
end

group :production do
#  gem 'exceptional'
#  gem 'newrelic_rpm', :require => false
  gem 'hassle', :git => 'git://github.com/Papipo/hassle'
end
