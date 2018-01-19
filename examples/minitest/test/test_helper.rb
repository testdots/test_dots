require 'rubygems'
require 'bundler/setup'
require 'test_dots'
require 'minitest/autorun'

TestDots.configure do |config|
  config.use_ssl = false
end
