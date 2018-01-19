require 'json'
require "net/http"

require "test_dots/version"
require "test_dots/configuration"
require "test_dots/api"

require "test_dots/ci_adapters/base"
require "test_dots/ci_adapters/travis_ci"
require "test_dots/ci_adapters/jenkins"
require "test_dots/ci_adapters/circle_ci"

module TestDots
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.register_rspec_listener
    if configuration.collect_test_data?
      require 'test_dots/rspec_listener'
      TestDots::RSpecListener.register
    end
  end

  def self.configure
    yield(configuration)
  end

  def self.host
    configuration.host
  end

  def self.send_report(attributes)
    ci_adapter = configuration.ci_adapter
    api = TestDots::Api.new

    attributes = attributes.merge(
      gem_version: TestDots::VERSION,
      ci_adapter: ci_adapter.class.to_s,
      url: ci_adapter.url,
      build: ci_adapter.build,
      branch: ci_adapter.branch,
    )

    api.post(attributes.to_json)
  end
end
