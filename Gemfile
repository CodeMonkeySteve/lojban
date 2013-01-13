source :gemcutter

# Core
gem 'railties'
gem 'actionmailer'

# I/O
gem 'em-synchrony', require: ['em-synchrony', 'em-synchrony/em-http'] 
gem 'em-http-request', git: 'git://github.com/igrigorik/em-http-request.git', require: 'em-http'
gem 'rack-fiber_pool',  require: 'rack/fiber_pool'

# Database
gem 'mongoid',  '~> 2.0'
gem 'bson', '< 1.4'
gem 'bson_ext', '< 1.4'

# Authentication
gem 'devise' #, git: 'git://github.com/plataformatec/devise.git'  
gem 'warden-openid'
gem 'rack-openid', require: 'rack/openid'
gem 'openid_mongodb_store'

# Misc

group :assets do
  gem 'sass-rails'
  gem 'uglifier'
  #gem 'hassle', git: 'git://github.com/Papipo/hassle.git'
end
gem 'haml-rails' #, git: 'git://github.com/bgentry/haml-rails.git'

group :development do
  gem 'debugger'
  gem 'thin'
  gem 'rails3-generators', git: 'https://github.com/indirect/rails3-generators.git'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'spork'
  gem 'webrat'
end
