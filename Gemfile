source :gemcutter

# Core
gem 'bundler', '~> 1.0.0.rc.2'
gem 'rails', '~> 3.0.0.rc' #:git => 'http://github.com/rails/rails.git'  #'~> 3.0.0.beta4'
gem 'rails3-generators'

# I/O
gem 'eventmachine', '= 0.12.10'   # must be same as Heroku
gem 'rack-fiber_pool',  :require => 'rack/fiber_pool'
gem 'em-synchrony', :require => [ 'em-synchrony', 'em-synchrony/em-http' ],
#  :git => 'git://github.com/igrigorik/em-synchrony.git'
  :git => 'git://github.com/CodeMonkeySteve/em-synchrony.git'
#  :path => '/home/steve/src/forks/em-synchrony'
gem 'em-http-request' #, :git => 'git://github.com/igrigorik/em-http-request.git' #, :require => 'em-http'
gem 'thin'

# Database
gem 'em-mongo'
gem 'mongoid',  '~> 2.0.0.beta.15'
gem 'bson',     '1.0.4'  # must be same as bson_ext
gem 'bson_ext', '1.0.4'  # must be same as bson

# Authentication
gem 'devise', :git => 'http://github.com/plataformatec/devise.git'  #'~> 1.1.rc2'
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
    gem 'factory_girl_rails'
    gem 'rspec-rails', '~> 2.0.0.beta.19'
    gem 'spork'
    gem 'webrat'
  end
end

group :production do
#  gem 'exceptional'
  gem 'hassle'
#  gem 'newrelic_rpm', :require => false
end
