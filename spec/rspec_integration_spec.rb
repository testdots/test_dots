require "spec_helper"
require 'pathname'
require 'rspec'

RSpec.describe 'rspec integration' do
  before do
    start_fake_api_server
  end

  it "posts data about an rspec spec run" do
    Dir.chdir(File.join(example_root, 'rspec')) do
      Bundler.with_original_env do
        system(fake_server_env, 'bundle exec rspec --out test_output.log spec')
      end
    end

    requests = requests_made_to_fake_api_server

    expect(requests.count).to eq(1)
    request = requests.first

    expect(request['path']).to eq('/api/v1/builds')
    payload = JSON.parse(request['body'])

    expect(payload).to have_key('load_time')
    expect(payload).to have_key('run_time')
    expect(payload).to have_key('results')
    expect(payload['results'].count).to eq(4)
    expect(payload['results'].map{|r| r['status']}).to contain_exactly("passed", "passed", "passed", "failed")
  end
end
