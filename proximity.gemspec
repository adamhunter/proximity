# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'proximity/version'

Gem::Specification.new do |spec|
  spec.name          = "proximity"
  spec.version       = Proximity::VERSION
  spec.authors       = ["Adam Hunter", "Zach Colon"]
  spec.email         = ["adamhunter@me.com", "zcolon80@gmail.com"]
  spec.description   = %q[Rack::Proxy router using Journey]
  spec.summary       = %q[Proximity provides a router to applications utilizing Rack::Proxy to coordinate the source and target of a request.]
  spec.homepage      = "https://github.com/adamhunter/proximity"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
