SshCommand = "ssh -S '~/.ssh/master-%l-%r@%h:%p'"
Doo::Base.class_eval do
  def run_on_server(servers, variables = {}, &block)
    servers.each do |host, params|
      with_clone(variables.merge({:host => host}).merge(params || {})) do
        def run(cmd, opt = {})
          puts "Running ssh #{(!opt.include? :pty || opt[:pty])? '-t' : ''} #{host} \"#{cmd}\"" if verbose
          system("#{SshCommand} #{(!opt.include? :pty || opt[:pty])? '-t' : ''} #{host} \"#{cmd}\"") || raise("SSH Error") unless dry_run
          $?
        end
      
        def put(local, remote)
          puts "scp -r \"#{local}\" \"#{host}:#{remote}\"" if verbose
          system("scp -r \"#{local}\" \"#{host}:#{remote}\"") || raise("SSH Error") unless dry_run
          $?
        end
      
        begin
          system("#{SshCommand} -MNf #{host}") || raise("SSH Error") unless dry_run
          instance_eval &block if block_given?
        ensure
          system("#{SshCommand} -Oexit #{host}") || raise("SSH Error") unless dry_run
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
