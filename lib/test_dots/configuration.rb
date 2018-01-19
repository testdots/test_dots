module TestDots
  class Configuration
    attr_accessor :enabled, :host, :port, :api_key, :endpoint, :use_ssl, :cacert_path, :ci_adapter

    def initialize
      @enabled = true
      @host = ENV.fetch('TEST_DOTS_HOST', 'testdots.com')
      @port = port = ENV.fetch('TEST_DOTS_PORT', '443')
      @api_key = ENV.fetch('TEST_DOTS_KEY', nil)
      @endpoint = ENV.fetch('TEST_DOTS_ENDPOINT', '/api/v1/builds')
      @use_ssl = true
      @cacert_path = File.expand_path(File.join('..', '..', '..', 'resources', 'cacert.pem'), __FILE__)
      @ci_adapter = default_ci_adapter
    end

    def collect_test_data?
      enabled && api_key
    end

    private

    def default_ci_adapter
      [
        TestDots::CIAdapters::TravisCI.new,
        TestDots::CIAdapters::Jenkins.new,
        TestDots::CIAdapters::CircleCI.new,
        TestDots::CIAdapters::Base.new
      ].find {|a| a.active?}
    end
  end
end
