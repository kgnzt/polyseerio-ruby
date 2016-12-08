require 'functional'
require 'concurrent'
require 'agent/handler/interface'

# Helper functions for Agent
module Helper
  # Returns an iteration function for a handler item.
  private_class_method def self.create_handler_iteratee (handlers, iteratee, **args)
    Proc.new { |key, value|
      if handlers.key? key
        iteratee.call(handlers, key, value, *args)
      else
        Concurrent::Promise.reject("Could not find a handler subtype: #{key}.")
      end
    }
  end

  # Returns a handler function.
  private_class_method def self.create_handler (iteratee)
    Proc.new { |handler, type, config, **args|
      if handler.key? type
        work = config.map &iteratee.call(handler.fetch(type), *args)

        Concurrent::Promise.zip *work
      else
        Concurrent::Promise.reject("Could not find a handler type: #{type}.");
      end
    }
  end

  # Returns a setup handler function.
  @setup = Proc.new { |handlers, **args|
    _setup = Proc.new { |handlers, key, value, **args|
      handler = handlers.fetch(key)

      if handler.respond_to? :call
        handler.call(*args)
      elsif handler.key? HandlerInterface::SETUP
        handler[HandlerInterface::SETUP].call(*args)
      else
        Concurrent::Promise.fulfill()
      end
    }

    create_handler_iteratee(handlers, _setup, *args)
  }

  @teardown = lambda { |handles, **args|
    _teardown = lambda { |handlers, value, item, **args|
      if handlers.fetch(item).key? HanlderInterface::TEARDOWN
        return handlers.fetch(item).fetch(HandlerInterface::Teardown).call(*args)
      end

      Concurrent::Promise.fulfill()
    }

    create_handler_iteratee(handlers, _teardown, *args)
  }

  def self.setup_with_handler(*args)
    create_handler(@setup).curry().call(*args)
  end

  # Performs handler teardown.
  #self.teardown_with_handler = create_handler(teardown)

  # Returns a unique name.
  def self.generate_name()
    'ruby-instance'
  end

  # Determines if a handler configuration should be handled.
  def self.should_handle(value)
    return value if value === true

    if Functional::TypeCheck::Type?(value, Hash) && (value.key? :enabled)
      return value[:enabled]
    end

    false
  end

  # Given an agent config a name will be returned.
  def self.resolve_name(config)
    return config[:name] if (config.key?(:name) && config[:name] != nil)

    generate_name
  end
end
