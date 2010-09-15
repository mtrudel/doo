Doo::Base.class_eval do
  def render_to_file(filename, variables = {}, &block)
    File.open(filename, 'w') do |file|
      with_clone(variables) do
        @file = file
        def run(cmd)
          puts "Rendering #{cmd}" if verbose
          @file.puts cmd
        end
        check_prereqs do
          instance_eval &block if block_given?
        end
      end
    end
  end
end