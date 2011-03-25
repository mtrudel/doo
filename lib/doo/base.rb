module Doo
  class Base    
    def load(filename)
      filename = find_file_in_load_path(filename)
      instance_eval(File.read(filename), filename)
    end

    def initialize(variables = {})
      using variables
    end
            
    def using(variables = {})
      variables.each { |k,v| set k, v }
    end
    
    def set(k, v=nil, &block)
      singleton_class.class_eval do
        define_method k, (block_given?)? Proc.new { |*args|
          if args.empty?
            instance_eval &block
          else
            with_clone(args[0], &block)
          end
        } : lambda {v}
      end
    end
    
    def with_clone(variables = {}, &block)
      obj = clone
      obj.using variables
      obj.instance_eval &block if block_given?
      obj
    end

    private
    def singleton_class
      class << self
        self
      end
    end

    def find_file_in_load_path(file)
      (["/", "."] + $:).each do |path|
        ["", ".rb"].each do |ext|
          name = File.join(path, "#{file}#{ext}")
          return name if File.file?(name)
        end
      end

      raise LoadError, "no such file to load -- #{file}"
    end
  end
end
