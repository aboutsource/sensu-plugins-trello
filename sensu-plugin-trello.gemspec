# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sensu/plugin/trello/version'

Gem::Specification.new do |spec|
  spec.name          = "sensu-plugin-trello"
  spec.version       = Sensu::Plugin::Trello::VERSION
  spec.authors       = ["Hauke Altmann"]
  spec.email         = ["hauke.altmann@aboutsource.net"]

  spec.summary       = 'Check if a Trello list contains card(s)'
  spec.description   = 'Used for incident management where a card represents an incident.'
  spec.homepage      = "https://github.com/aboutsource/sensu-plugin-trello"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = Dir.glob('bin/**/*.rb').map { |file| File.basename(file) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'sensu-plugin', '~> 2.1'
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
