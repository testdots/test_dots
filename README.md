## TestDots

This is the Ruby gem for the [Test Dots CI performance monitoring service](https://testdots.com/).

## Installation instructions for a Rails Project

**1.** Add TestDots to your project's Gemfile in the 'test' group.

```ruby
group :test do
  gem 'test_dots'
end
```

**2.** If you are using RSpec, add the following to your `spec_helper.rb` file. This is not needed for MiniTest.

```ruby
TestDots.register_rspec_listener
```

**3.** If you are using a tool such as `WebMock` or `VCR` to prevent connections to the internet in your test environment add an exception for Test Dots.

```ruby
VCR.config do |c|
  c.ignore_hosts TestDots.host
end
```

```ruby
WebMock.disable_net_connect!(allow: TestDots.host)
```
**4.** Configure your API key by setting the `TEST_DOTS_KEY` environment variable in your continuous integration tool.


## Integrating with Test Frameworks

Test Dots integrates with different test frameworks to get timing and result information about your tests.

### Supported Test Frameworks
+ RSpec
+ MiniTest

## Integrating with CI services

The TestDots gem integrates with different CI services to gather more information about each of your builds. It does this by looking at the environment variables CI services set such as the build number and the name of the branch being built.

### Supported CI services
+ TravisCI
+ CircleCI
+ Jenkins

### Writing a custom adapter

If you want to write your own CI adapter you should:
+ Subclass `TestDots::CIAdapters::Base`
+ Implement any of the `branch`, `build` and `url` methods
  + `build` should return a unique identifier to represent the build. Multiple parts of the same build can return the same value.
  + `url` should return be a URL that can be followed to view this build in you CI service.
  + `branch` should return be the name of commit or branch being built
+ Change the `ci_adapter` configuration option to use your adapter.

For example, for a fictional 'CoolCI' service, you might write:

```ruby
class CoolCI < TestDots::CIAdapters::Base
  def branch
    ENV['COOL_CI_BRANCH']
  end

  def build
    ENV['COOL_CI_BUILD_NUM']
  end

  def url
    ENV['COOL_CI_BUILD_URL']
  end
end

TestDots.configure do |config|
  config.ci_adapter = CoolCI.new
end
```


## Configuration options

You can override the default configuration options by passing a block to `TestDots.configure`. This can be done in your `test_helper.rb` or `spec_helper.rb` files.

```ruby
TestDots.configure do |config|
  config.api_key = ENV['MY_TEST_DOTS_KEY']
end
```

| Option | Use  | Default |
|:-:|:-:|:-:|
| `api_key`  | Your projects API key. If not set, the test suite will not be monitored  | The value of the `TEST_DOTS_KEY` environment variable |
| `ci_adapter`  | What CI service to integrate with | Picks the an adapter based on the [supported CI services](#Supported-CI-Services) |
