require 'rspec/core/rake_task'
desc "Run all tests"
RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = 'spec/**/*.rb'
end

task :default => :spec
