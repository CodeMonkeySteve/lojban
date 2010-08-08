require 'bundler'
Bundler.setup
Bundler.require :default, :test

Autotest.add_discovery { 'rails' }
Autotest.add_discovery { 'rspec2' }
