# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dom_glancy/version'

Gem::Specification.new do |spec|
  spec.name          = "dom_glancy"
  spec.version       = DomGlancy::VERSION
  spec.authors       = ["geordie"]
  spec.email         = ["george.speake@gmail.com"]
  spec.description   = %q{DOM Mapping}
  spec.summary       = %q{Map the page DOM and get some stats on it compared to a known default map.}
  spec.homepage      = "https://github.com/QuantumGeordie/dom_glancy"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency 'kramdown', '~> 1.1.0'
  spec.add_dependency 'capybara', ['>= 1.0', '< 3']
end
