Doo::Base.class_eval do
  def run_on_server(servers, variables = {}, &block)
    servers.each do |host, params|
      with_clone(variables.merge({:host => host}).merge(params || {})) do
        def run(remote_cmd, opts = {})
          cmdopts = ["-S \"~/.ssh/master-%l-%r@%h:%p\""]
          cmdopts << "-t" if !opts.include? :pty || opts[:pty]
          cmdopts << "-p#{ssh_port}" if defined? ssh_port
          remote_cmd = sudoize(remote_cmd) if opts[:sudo]
          run! "ssh #{cmdopts.join(' ')} #{user}@#{host} \"#{remote_cmd.gsub(/\"/, "\\\"")}\"", opts
        end

        def put(local, remote, opts = {})
          cmdopts = ["-r"]
          cmdopts << "-oProxyCommand=\"ssh #{gateway} exec nc %h %p\"" if defined?(gateway) && gateway
          cmdopts << "-P#{ssh_port}" if defined? ssh_port
          result = run! "scp #{cmdopts.join(' ')} #{local} #{user}@#{host}:#{remote}"
          run "chmod #{opts[:mode]} #{remote}" if defined? opts[:mode]
          result
        end

        begin
          cmdopts = ["-MNf -S \"~/.ssh/master-%l-%r@%h:%p\""]
          cmdopts << "-oProxyCommand=\"ssh #{gateway} exec nc %h %p\"" if defined?(gateway) && gateway
          cmdopts << "-p#{ssh_port}" if defined? ssh_port
          run! "ssh #{cmdopts.join(' ')} #{user}@#{host}"

          # Now run the actual commands
          instance_eval &block if block_given?
        ensure
          cmdopts = ["-Oexit -S \"~/.ssh/master-%l-%r@%h:%p\""]
          run! "ssh #{cmdopts.join(' ')} #{user}@#{host}"
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
