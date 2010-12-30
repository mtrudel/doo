require 'highline'
require 'colorize'

Doo::Base.class_eval do
  SEPARATORS = %w( / @ : | _ - # ^ ? )
  
  def replace(file, src, replace, opts = {})
    sep = SEPARATORS.detect { |x| !src.include?(x) && !replace.include?(x) }
    run "sed -i -e 's#{sep}#{src.escape_for_shell}#{sep}#{replace.escape_for_shell}#{sep}g' #{file}", opts
  end
  
  def append(file, text, opts = {})
    run "grep '#{text.escape_for_shell}' #{file} || echo '#{text.escape_for_shell}' >> #{file}", opts
  end
  
  def sudo(cmd, opts = {})
    run(cmd, opts.merge(:sudo => true))
  end
  
  class String
    def sudoize!
      replace "sudo sh -c \"#{escape_for_shell}\""
    end

    def escape_for_shell
      gsub "\"", "\\\""
    end
  end
  
  private
  def run!(cmd, opts = {})
    with_clone(opts) do
      if confirm
        return false unless HighLine.new.agree("Run \"#{cmd}\"? ")
      elsif verbose
        puts "Running \"#{cmd}\"".green
      end
      unless dry_run
        if defined?(capture) && capture
          return `#{cmd}`
        else
          system cmd
          if $? != 0 && (!defined? return_on_failure || !return_on_failure)
            puts "Error code #{$?} running #{cmd}".red 
            raise
          end
          puts "Got exit code #{$?.exitstatus}" if verbose
          return $?.exitstatus
        end
      else
        true
      end
    end
  end
end
