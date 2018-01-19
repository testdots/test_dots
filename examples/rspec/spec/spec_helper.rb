require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'test_dots'

TestDots.configure do |config|
  config.use_ssl = false
end

TestDots.register_rspec_listener
