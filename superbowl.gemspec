# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'superbowl/version'

Gem::Specification.new do |spec|
  spec.name          = 'superbowl'
  spec.version       = Superbowl::VERSION
  spec.authors       = ['Matt Gillooly']
  spec.email         = ['matt@swipely.com']
  spec.summary       = 'Use data to predict your Super Bowl pool outcome.'
  spec.homepage      = 'http://github.com/mattgillooly/superbowl'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop'

  spec.add_dependency 'nokogiri'
end
