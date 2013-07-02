# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coordsafe_api/version'

Gem::Specification.new do |spec|
  spec.name          = "coordsafe_api"
  spec.version       = CoordsafeApi::VERSION
  spec.authors       = ["Vincent Paca"]
  spec.email         = ["vincent.paca@gmail.com"]
  spec.description   = %q{A ruby wrapper for the Coordsafe locator API}
  spec.summary       = %q{Wrapper for the Coordsafe API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.6"
end
