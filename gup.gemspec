# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gup/version'

Gem::Specification.new do |spec|
  spec.name          = "gup"
  spec.version       = Gup::VERSION
  spec.authors       = ["ksilin"]
  spec.email         = ["konstantin.silin@gmail.com"]
  spec.summary       = %q{Updates all git repos}
  spec.description   = %q{Update all git repos recursively}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['gup']#spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "git-up"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency'fakefs'#, require: 'fakefs/safe'
end
