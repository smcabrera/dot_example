# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dot_example/version'

Gem::Specification.new do |spec|
  spec.name          = "dot_example"
  spec.version       = DotExample::VERSION
  spec.authors       = ["Stephen Mariano Cabrera"]
  spec.email         = ["stephen.m.cabrera@gmail.com"]

  spec.description = spec.summary = DotExample::SUMMARY
  spec.homepage      = "https://www.github.com/smcabrera/dot_example"
  spec.license       = "MIT"

  #spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.files = Dir["{bin,lib}/**/*", "LICENSE", "README.md"]
  #spec.bindir        = "exe"
  #spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.executables = ['dot_example']
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'commander', '~> 4.4'
  spec.add_runtime_dependency 'dotenv', '~> 2.1', '>= 2.1.1'
  spec.add_runtime_dependency 'paint', '1.0.0'
  spec.add_runtime_dependency 'aruba', '~> 0.14.2'

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency 'jazz_fingers', '~> 4.0', '>= 4.0.1'
end
