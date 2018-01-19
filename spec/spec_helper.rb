require "bundler/setup"
require "test_dots"

require 'fake_api_server_helper'
require 'path_helpers'

TestDots.configure do |config|
  config.enabled = false
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include FakeApiServerHelper
  config.include PathHelpers
end
