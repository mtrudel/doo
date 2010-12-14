require 'highline'

Doo::Base.class_eval do
  def run_on_server(servers, variables = {}, &block)
    servers.each do |host, params|
      with_clone(variables.merge({:host => host}).merge(params || {})) do
        def run(remote_cmd, opt = {})
          cmdopts = ["-S \"~/.ssh/master-%l-%r@%h:%p\""]
          cmdopts << "-t" if !opt.include? :pty || opt[:pty]          
          cmdopts << "-p#{ssh_port}" if defined? ssh_port
          cmd = "ssh #{cmdopts.join(' ')} #{user}@#{host} \"#{remote_cmd.gsub(/\"/, "\\\"")}\""
          if confirm
            return false unless HighLine.new.agree("Run \"#{cmd}\"? ")
          elsif verbose
            puts "Running \"#{cmd}\""
          end
          system(cmd) || raise("SSH Error") unless dry_run
          $?
        end

        def put(local, remote, opt = {})
          cmdopts = ["-r"]
          cmdopts << "-oProxyCommand=\"ssh #{gateway} exec nc %h %p\"" if defined?(gateway) && gateway
          cmd = "scp #{cmdopts.join(' ')} #{local} #{user}@#{host}:#{remote}"
          if confirm
            return false unless HighLine.new.agree("Run \"#{cmd}\"? ")
          elsif verbose
            puts "Running \"#{cmd}\""
          end
          system(cmd) || raise("Scp Error") unless dry_run
          $?
        end

        begin
          cmdopts = ["-MNf -S \"~/.ssh/master-%l-%r@%h:%p\""]
          cmdopts << "-oProxyCommand=\"ssh #{gateway} exec nc %h %p\"" if defined?(gateway) && gateway
          command = "ssh #{cmdopts.join(' ')} #{user}@#{host}"
          puts "Running #{command}" if verbose
          system(command) || raise("SSH Error") unless dry_run
          
          instance_eval &block if block_given?
        ensure
          cmdopts = ["-Oexit -S \"~/.ssh/master-%l-%r@%h:%p\""]
          command = "ssh #{cmdopts.join(' ')} #{user}@#{host}"
          puts "Running #{command}" if verbose
          system(command) || raise("SSH Error") unless dry_run
        end
      end
    end
  end
end

Hash.class_eval do
  def with_role(role)
    reject { |k,v| ! [v[:role]].flatten.member? role }
  end

  def except_role(role)
    reject { |k,v| [v[:role]].flatten.member? role }
  end
end
