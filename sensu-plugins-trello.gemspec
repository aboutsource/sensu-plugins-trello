lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sensu/plugins/trello/version'

Gem::Specification.new do |spec|
  spec.name          = 'sensu-plugins-trello'
  spec.version       = Sensu::Plugins::Trello::VERSION
  spec.authors       = ['Hauke Altmann', 'Stefan Walluhn']
  spec.email         = ['hauke.altmann@aboutsource.net']

  spec.summary       = 'Check if a Trello list contains card(s)'
  spec.description   = 'Used for incident management where a card represents '\
                       'an incident.'
  spec.homepage      = 'https://github.com/aboutsource/sensu-plugins-trello'
  spec.require_paths = ['lib']

  spec.executables = Dir.glob('bin/**/*.rb').map { |file| File.basename(file) }
  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.add_dependency 'sensu-plugin', '~> 2.1'
  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'rubocop', '~> 0.54'
  spec.add_development_dependency 'webmock', '~> 3.3'
end
