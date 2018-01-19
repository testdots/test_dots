require 'capybara'
require 'sinatra'
require 'sinatra/base'

module FakeApiServerHelper
  class FakeApiServer < Sinatra::Base
    Requests = []

    def self.boot
      instance = new
      Requests.clear
      Capybara::Server.new(instance).tap { |server| server.boot }
    end

    get '/requests' do
      Requests.to_json
    end

    post '/*' do
      Requests << {
        path: request.path,
        body: request.body.read
      }
    end
  end

  def start_fake_api_server
    @server = FakeApiServer.boot
  end

  def fake_server_env
    {
      'TEST_DOTS_SERVER' => @server.host,
      'TEST_DOTS_PORT' => @server.port.to_s,
      'TEST_DOTS_KEY' => 'dummy-key'
    }
  end

  def requests_made_to_fake_api_server
    JSON.parse(`curl -s #{@server.host}:#{@server.port}/requests`)
  end
end
