# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'concise_logging/version'

Gem::Specification.new do |spec|
  spec.name          = "concise_logging"
  spec.version       = ConciseLogging::VERSION
  spec.authors       = ["Gerry Shaw"]
  spec.email         = ["gerry_shaw@yahoo.com"]
  spec.summary       = %q{Alternate logging for Rails production servers}
  spec.homepage      = "https://github.com/gshaw/concise_logging"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "railties", ">= 4.2"
  spec.add_runtime_dependency "activesupport", ">= 4.2"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.9"
end
