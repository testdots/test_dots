require 'rubygems'
require 'bundler/setup'
require 'rspec'
require 'test_dots'

TestDots.configure do |config|
  config.use_ssl = false
end

TestDots.register_rspec_listener

RSpec.describe "example" do
  describe 'odd and even' do
    context 'a group of tests' do
      it 'returns true' do
        expect(2.even?).to be(true)
      end

      it 'returns false' do
        expect(5.even?).to be(false)
      end
    end

    context 'a different' do
      it 'returns true' do
        expect(3.odd?).to be(true)
      end

      it 'returns false' do
        expect(6.odd?).to be(false)
      end
    end
  end

  it 'is failing' do
    expect(true).to be(false)
  end

  it 'errors' do
    raise 'hi'
  end

  it 'is intermittent' do
    random = rand
    expect(random).to be > 0.5
  end

  it 'it is variably slow' do
    sleep(rand * 2)
    expect(true).to be(true)
  end

  it 'is slow' do
    sleep(1.5)
    expect(true).to be(true)
  end
end
