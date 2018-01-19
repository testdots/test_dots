# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "test_dots/version"

Gem::Specification.new do |spec|
  spec.name          = "test_dots"
  spec.version       = TestDots::VERSION
  spec.authors       = ["Chris Zetter"]
  spec.email         = ["zetter@users.noreply.github.com"]

  spec.summary       = %q{Monitor the performance of your test suite}
  spec.homepage      = "https://github.com/testdots/test_dots"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.files        += Dir['resources/*.crt']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "capybara", "~> 2.0"
  spec.add_development_dependency "sinatra", "~> 2.0"
end
