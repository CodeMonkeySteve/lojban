source :gemcutter

# Core
gem 'bundler', '~> 1.0.0.rc'
gem 'railties', '~> 3.0.0.rc'
gem 'actionmailer', '~> 3.0.0.rc'
gem 'rails3-generators'

# I/O
gem 'eventmachine', '= 0.12.10'   # must be same as Heroku
gem 'rack-fiber_pool',  :require => 'rack/fiber_pool'
gem 'em-synchrony', :require => [ 'em-synchrony', 'em-synchrony/em-http' ],
#  :git => 'git://github.com/igrigorik/em-synchrony.git'
  :git => 'git://github.com/CodeMonkeySteve/em-synchrony.git'
gem 'em-http-request' #, :git => 'git://github.com/igrigorik/em-http-request.git' #, :require => 'em-http'
gem 'thin'

# Database
gem 'mongo',
  #:git => 'git://github.com/mongodb/mongo-ruby-driver.git', :require => 'mongo'
  '~> 1.0.8'
gem 'mongoid',  :git => 'git://github.com/CodeMonkeySteve/mongoid.git'  #'~> 2.0.0.beta'
gem 'bson',     '~> 1.0.7'  # must be same as bson_ext
gem 'bson_ext', '~> 1.0.7'  # must be same as bson

# Authentication
gem 'devise', :git => 'git://github.com/plataformatec/devise.git'  #'~> 1.1.rc2'
gem 'warden-openid'
gem 'rack-openid', :require => 'rack/openid'
#gem 'openid_mongodb_store'

# Misc
gem 'haml', '~> 3.0.3'

unless ENV['USER'] =~ /^repo\d+$/   # kludge to exclude on Heroku
  group :development do
    gem 'autotest-rails'
    gem 'launchy'        # for Cucumber's "Show Me The Page"
    gem 'ruby-debug19',  :require => 'ruby-debug'
  end

  group :test do
    gem 'database_cleaner'
    gem 'factory_girl_rails', :git => 'git://github.com/CodeMonkeySteve/factory_girl_rails.git'
    gem 'factory_girl', :git => 'git://github.com/thoughtbot/factory_girl.git'
    gem 'rspec-rails', '~> 2.0.0.beta'
    gem 'spork'
    gem 'webrat'
  end
end

group :production do
#  gem 'exceptional'
  gem 'hassle'
#  gem 'newrelic_rpm', :require => false
end
