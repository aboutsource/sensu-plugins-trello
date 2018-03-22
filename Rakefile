require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec) do |r|
  r.pattern = FileList['test/**/*_spec.rb']
end

RuboCop::RakeTask.new

task default: %i[rubocop spec]
