require 'optparse'
require 'doo'

module Doo
  module CLI
    module Options
      def self.parse!(args)
        options = {}
        optparse = OptionParser.new do |opts|
          opts.banner = "Usage: doo [options] file1 file2 ..."
          
          options[:verbose] = false
          opts.on( '-v', '--verbose', 'Output more information' ) do
            options[:verbose] = true
          end
          
          options[:confirm] = false
          opts.on( '-c', '--confirm', 'Confirm every command before it gets run' ) do
            options[:confirm] = true
          end
          
          opts.on( '-s', '--set key=value', 'Set runtime values' ) do |arg|            
            options[arg.split('=')[0]] = arg.split('=')[1]
          end
          
          options[:dry_run] = false
          opts.on( '-d', '--dry-run', 'Do a dry-run' ) do
            options[:dry_run] = true
          end
          
          opts.on( '-h', '--help', 'Display this screen' ) do
            puts opts
            exit
          end
        end
        begin
          optparse.parse!(args)
          raise "You need to specify one or more files to process" if args.empty?
        rescue 
          puts $!
          puts optparse
          exit
        end
        
        options
      end
    end
  end
end

module Doo
  module CLI
    def self.start
      inst = Doo::Base.new(Options.parse!(ARGV))
      ARGV.each do |filename|
        inst.load(filename)
      end
    end
  end
end
