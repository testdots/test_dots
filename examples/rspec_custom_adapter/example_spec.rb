require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'test_dots'

class MyAdapter < TestDots::CIAdapters::Base
  def build
    'a-build'
  end

  def branch
    'a-branch'
  end

  def url
    'http://example.com/a-url'
  end
end

TestDots.configure do |config|
  config.use_ssl = false
  config.ci_adapter = MyAdapter.new
end

TestDots.register_rspec_listener

RSpec.describe "example" do
  describe 'odd and even' do
    it 'returns true' do
      expect(2.even?).to be(true)
    end

    it 'returns false' do
      expect(5.even?).to be(false)
    end
  end
end
