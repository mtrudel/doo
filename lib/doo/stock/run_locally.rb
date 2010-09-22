require 'highline'

Doo::Base.class_eval do
  def run_locally(variables = {}, &block)
    with_clone(variables) do
      def run(cmd)
        if confirm
          return false unless HighLine.new.agree("Run #{cmd}? ")
        elsif verbose
          puts "Running #{cmd}"
        end
        system cmd unless dry_run
        $?
      end
      instance_eval &block if block_given?
    end
  end
end
