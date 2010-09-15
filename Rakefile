begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.version
    gem.name            = "doo"
    gem.summary         = %Q{Doo - an stacked-cotnext approach to deployment scripting }
    gem.description     = %Q{Doo is a deployment scripting tool in the vein of capistrano and sprinkle that uses stacked contexts and a aspect-ish data model}
    gem.homepage        = "http://github.com/mtrudel/doo"
    gem.authors         = [ "Mat Trudel" ]
    gem.email           = [ "mat@geeky.net" ]
    gem.executables     = %W(doo)
    gem.files           = FileList["[A-Z]*", "{bin,examples,lib,spec}/**/*", 'lib/jeweler/templates/.gitignore']
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
desc "Run all tests"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
end

task :default => :spec