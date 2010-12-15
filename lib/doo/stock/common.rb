require 'highline'

Doo::Base.class_eval do
  SEPARATORS = %w( / @ : | _ - # ^ ? )
  
  def replace(file, src, replace, opts = {})
    sep = SEPARATORS.detect { |x| !src.include?(x) && !replace.include?(x) }
    run "sed -i -e 's#{sep}#{src}#{sep}#{replace}#{sep}g' #{file}", opts
  end
  
  def append(file, text, opts = {})
    run "grep '#{text}' #{file} || echo '#{text}' >> #{file}", opts
  end
  
  def sudo(cmd, opts = {})
    run(cmd, opts.merge(:sudo => true))
  end
  
  private
  def sudoize(cmd)
    "sudo sh -c \"#{cmd.gsub(/\"/, "\\\"")}\""
  end
  
  def run!(cmd, opts = {})
    with_clone(opts) do
      if confirm
        return false unless HighLine.new.agree("Run \"#{cmd}\"? ")
      elsif verbose
        puts "Running \"#{cmd}\""
      end
      unless dry_run
        system cmd
        raise "Error code #{$?}" if $? != 0 && (!defined? just_return_failure || !just_return_failure)
        return $?.exitstatus
      end
    end
  end
end
