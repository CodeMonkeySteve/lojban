source :gemcutter

# Core
gem 'bundler', '~> 1.0.0'
gem 'railties', '~> 3.0.0'
gem 'actionmailer', '~> 3.0.0'
gem 'rails3-generators'

# I/O
gem 'rack-fiber_pool',  :require => 'rack/fiber_pool'
gem 'em-synchrony', :require => [ 'em-synchrony', 'em-synchrony/em-http' ], :git => 'git://github.com/igrigorik/em-synchrony.git'
gem 'em-http-request' #, :git => 'git://github.com/igrigorik/em-http-request.git' #, :require => 'em-http'

# Database
gem 'mongoid', :git => 'git://github.com/mongoid/mongoid.git' #'~> 2.0.0.beta'
gem 'mongo', '~> 1.1.0'
gem 'bson',     '~> 1.0.9'  # must be same as bson_ext
gem 'bson_ext', '~> 1.0.9'  # must be same as bson

# Authentication
gem 'devise', :git => 'git://github.com/plataformatec/devise.git'  #'~> 1.1.2'
gem 'warden-openid'
gem 'rack-openid', :require => 'rack/openid'
gem 'openid_mongodb_store'

# Misc
gem 'haml-rails', :git => 'git://github.com/bgentry/haml-rails.git'

if (ENV['RACK_ENV'] == 'production') || (ENV['USER'] =~ /^repo\d+$/)  # kludge for Heroku
  group :production do
    gem 'hassle', :git => 'git://github.com/Papipo/hassle.git'
  end
else
  group :development do
    gem 'autotest-rails'
    gem 'eventmachine', '= 0.12.10'   # must be same as Heroku
    gem 'ruby-debug19',  :require => 'ruby-debug'
    gem 'thin'
  end
  group :test do
    gem 'database_cleaner'

    gem 'factory_girl_rails', :git => 'git://github.com/CodeMonkeySteve/factory_girl_rails.git'
    gem 'rspec', '~> 2.0.0.rc'
    gem 'rspec-rails', '~> 2.0.0.rc'
    gem 'spork'
    gem 'webrat'
  end
end
