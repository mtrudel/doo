# You can set options like so
set :servers, {
  "example.com" => { :role => [:web, :db], :ip => "10.11.12.13" },
}
set :arg, "foo"

# options can also be blocks, in which case they become callable
set :show_uptime do
  run "uptime"
end

# You can run local commands inside a block
run_locally do
  run "echo #{arg}" # Will output 'foo'
end

# optionally giving the blocks overriding arguments
run_locally :arg => "bar" do
  run "echo #{arg}"# Will output 'bar'
end

# You can run a set of commands on all remote server like so
run_on_server servers do
  run "whoami"  
end

# You can run a set of commands based on roles like so
run_on_server servers.with_role(:web) do
  run "whoami"
end

# You can also define servers as bare hostnames...
run_on_server "otherhost.com" do
  run "hostname"
  # This runs the show_uptime block with the current set of variables
  show_uptime  
end

# You can run a block into a file like so
render_to_file 'sample.out' do
  run "echo #{arg}" # Will ouput 'echo foo' to sample.out
end
