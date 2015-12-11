# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'data_mask/version'

Gem::Specification.new do |spec|
  spec.name          = "data_mask"
  spec.version       = Mask::VERSION
  spec.authors       = ["cuebyte"]
  spec.email         = ["cuebit.w@gmail.com"]

  spec.summary       = 'Data masking with Sequel.'
  spec.description   = 'Data masking with Sequel.'
  spec.homepage      = 'https://github.com/cuebyte/data_mask'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
end
