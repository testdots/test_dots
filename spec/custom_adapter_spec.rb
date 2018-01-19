require "spec_helper"
require 'pathname'
require 'rspec'

RSpec.describe 'custom adapter' do
  before do
    start_fake_api_server
  end

  it "posts data from the adapter" do
    Dir.chdir(File.join(example_root, 'rspec_custom_adapter')) do
      Bundler.with_original_env do
        system(fake_server_env, 'bundle exec rspec --out test_output.log example_spec.rb')
      end
    end

    requests = requests_made_to_fake_api_server

    expect(requests.count).to eq(1)
    request = requests.first

    expect(request['path']).to eq('/api/v1/builds')
    payload = JSON.parse(request['body'])

    expect(payload['build']).to eq('a-build')
    expect(payload['url']).to eq('http://example.com/a-url')
    expect(payload['branch']).to eq('a-branch')
    expect(payload['ci_adapter']).to eq('MyAdapter')

    expect(payload['results'].count).to eq(2)
  end
end
