Gem::Specification.new do |s|
  s.name = %q{doo}
  s.version = "0.6.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mat Trudel"]
  s.date = %q{2010-12-16}
  s.default_executable = %q{doo}
  s.description = %q{Doo is a deployment scripting tool in the vein of capistrano and sprinkle that uses stacked contexts and a aspect-ish data model}
  s.email = ["mat@geeky.net"]
  s.executables = ["doo"]
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.files = [
    "README.md",
    "Rakefile",
    "bin/doo",
    "examples/sample.rb",
    "lib/doo.rb",
    "lib/doo/base.rb",
    "lib/doo/cli.rb",
    "lib/doo/stock/common.rb",
    "lib/doo/stock/prereqs.rb",
    "lib/doo/stock/render_to_file.rb",
    "lib/doo/stock/run_locally.rb",
    "lib/doo/stock/run_on_server.rb",
    "spec/doo/base_spec.rb",
    "spec/doo/cli_spec.rb"
  ]
  s.homepage = %q{http://github.com/mtrudel/doo}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Doo - a stacked-context approach to deployment scripting}
  s.test_files = [
    "examples/sample.rb",
    "spec/doo/base_spec.rb",
    "spec/doo/cli_spec.rb"
  ]

  s.add_dependency("highline")
  s.add_dependency("colorize")
end

