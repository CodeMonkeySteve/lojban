source :gemcutter

# Core
gem 'bundler', '~> 1.0.0'
gem 'railties', '~> 3.0.1'
gem 'actionmailer', '~> 3.0.1'
gem 'rails3-generators'

# I/O
gem 'eventmachine', '= 0.12.10'   # must be same as Heroku
gem 'rack-fiber_pool',  :require => 'rack/fiber_pool'
gem 'em-http-request', :git => 'git://github.com/igrigorik/em-http-request.git', :require => 'em-http'
gem 'em-synchrony', :git => 'git://github.com/RailsPlay/em-synchrony.git', :require => ['em-synchrony', 'em-synchrony/em-http']

# Database
gem 'mongoid',  '~> 2.0.0.beta', :git => 'git://github.com/mongoid/mongoid.git'
gem 'bson_ext', '~> 1.1.1'

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
    gem 'ruby-debug19',  :require => 'ruby-debug'
    gem 'thin'
  end
  group :test do
    gem 'database_cleaner'
    gem 'factory_girl_rails', :git => 'git://github.com/RailsPlay/factory_girl_rails.git'
    gem 'rspec-rails', '~> 2.0.0'
    gem 'spork'
    gem 'webrat'
  end
end
