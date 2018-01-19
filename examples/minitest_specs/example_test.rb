require 'rubygems'
require 'bundler/setup'
require "minitest/autorun"
require 'test_dots'

TestDots.configure do |config|
  config.use_ssl = false
end

describe 'TestExample' do
  describe "passing" do
    it 'passes' do
      assert_equal true, true
    end
  end

  it 'fails' do
    assert_equal true, false
  end
end
