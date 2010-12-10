begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.version
    gem.name            = "doo"
    gem.summary         = %Q{Doo - an stacked-context approach to deployment scripting }
    gem.description     = %Q{Doo is a deployment scripting tool in the vein of capistrano and sprinkle that uses stacked contexts and a aspect-ish data model}
    gem.homepage        = "http://github.com/mtrudel/doo"
    gem.authors         = [ "Mat Trudel" ]
    gem.email           = [ "mat@geeky.net" ]
    gem.executables     = %W(doo)
    gem.files           = FileList["[A-Z]*", "{bin,examples,lib,spec}/**/*", 'lib/jeweler/templates/.gitignore']
    gem.add_dependency  "highline"
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rspec/core/rake_task'
desc "Run all tests"
RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = 'spec/**/*.rb'
end

task :default => :spec
