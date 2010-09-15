# You can set options like so
set :web, { :server => "example.com", :production => true }
set :arg, "foo"

# options can also be blocks, in which case they become callable
set :show_uptime do
  run "uptime"
end

# You can bind a variable's content into the current context like so
using web # Now 'server' and 'production' will be top-level variables

# You can run local commands inside a block
run_locally do
  run "echo #{arg}" # Will output 'foo'
end

# optionally giving the blocks overriding arguments
run_locally :arg => "bar" do
  run "echo #{arg}"# Will output 'bar'
end

# You can run a set of commands on a remote server like so
run_on_server web do
  run "whoami"  
end
# You can define servers as hashes or bare hostnames...
run_on_server [web, "otherhost.com"] do
  run "hostname"
  # This runs the show_uptime block with the current set of variables
  show_uptime  
end

# You can run a block into a file like so
render_to_file 'sample.out' do
  run "echo #{arg}" # Will ouput 'echo foo' to sample.out
end
