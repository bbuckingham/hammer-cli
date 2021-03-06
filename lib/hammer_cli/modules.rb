
module HammerCLI

  class Modules

    def self.names
      HammerCLI::Settings.get(:modules) || []
    end

    def self.find_by_name(name)
      possible_names = [
        name.camelize,
        name.camelize.gsub("Cli", "CLI")
      ]

      possible_names.each do |n|
        return Object.const_get(n) if Object.const_defined?(n)
      end
      return nil
    end

    def self.load!(name)
      begin
        require_module(name)
      rescue LoadError => e
        logger.error "Module #{name} not found"
        raise e
      rescue Exception => e
        logger.error "Error while loading module #{name}"
        logger.error e
        puts "Warning: An error occured while loading module #{name}"
        raise e
      end

      version = find_by_name(name).version
      logger.info "Extension module #{name} (#{version}) loaded"
      true
    end

    def self.load(name)
      load! name
    rescue Exception => e
      false
    end

    def self.require_module(name)
      require name
    end

    def self.load_all
      HammerCLI::Modules.names.each do |m|
        Modules.load(m)
      end
    end

    protected
    def self.logger
      Logging.logger['Modules']
    end

  end

end
