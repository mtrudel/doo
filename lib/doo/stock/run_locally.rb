Doo::Base.class_eval do
  def run_locally(variables = {}, &block)
    with_clone(variables) do
      def run(cmd, opts = {})
        cmd.sudoize! if opts[:sudo]
        run! cmd, opts
      end
      
      instance_eval &block if block_given?
    end
  end
end
