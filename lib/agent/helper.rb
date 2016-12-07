# Helper functions for Agent
module Helper
  # Returns a unique name.
  def self.generate_name()
    'ruby-test'
  end

  # Returns a unique name.
  def self.setup_with_handler(handler, type, config, ...args)
    raise ArgumentError, "Could not find a handler for type: #{type}" if !handler.key? type

    # iterater over config 
  end
end
