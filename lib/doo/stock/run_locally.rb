Doo::Base.class_eval do
  def run_locally(variables = {}, &block)
    with_clone(variables) do
      def run(cmd)
        puts "Running #{cmd}" if verbose
        system cmd unless dry_run
        $?
      end
      instance_eval &block if block_given?
    end
  end
end