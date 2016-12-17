require 'functional'
require 'concurrent'
require 'agent/handler/interface'

module Polyseerio
  module Agent
    # Helper functions for Agent
    module Helper
      # Returns an iterator for a handler subtype.
      def self.create_subtype_iterator(handlers, iteratee, *args)
        proc do |key, value|
          if handlers.key? key.to_sym # TODO: unit-test to_sym
            iteratee.call(handlers, key, value, *args)
          else
            Concurrent::Promise.reject('Could not find a handler subtype: ' \
              "#{key}.")
          end
        end
      end

      # Returns a handler function.
      def self.create_handler(iteratee)
        proc do |map, client, config, type, *args|
          if map.key? type.to_sym
            if config.key? type
              # TODO: unit-test passed args
              work = config.fetch(type)
                           .map(&iteratee.call(map.fetch(type), client, *args))

              Concurrent::Promise.zip(*work)
            else
              Concurrent::Promise.fulfill []
            end
          else
            Concurrent::Promise.reject('Could not find a handler type: ' \
              "#{type}.")
          end
        end
      end

      # Returns a setup handler function.
      @setup = proc do |handlers_outer, *args_outer|
        setup_iterator = proc do |handlers, key, value, *args|
          handler = handlers.fetch(key)

          if handler.respond_to? :call
            handler.call(value, *args) # TODO: unit-test passed args
          elsif handler.key? Handler::Interface::SETUP
            # TODO: unit-test passed args
            handler[Handler::Interface::SETUP].call(value, *args)
          else
            Concurrent::Promise.fulfill
          end
        end

        create_subtype_iterator(handlers_outer, setup_iterator, *args_outer)
      end

      @teardown = proc do |handlers_outer, *args_outer|
        teardown_iterator = proc do |handlers, key, _value, *args|
          if handlers.fetch(key).key? Handler::Interface::TEARDOWN
            handlers.fetch(key).fetch(Handler::Interface::TEARDOWN).call(*args)
          else
            Concurrent::Promise.fulfill
          end
        end

        create_subtype_iterator(handlers_outer, teardown_iterator, *args_outer)
      end

      # Sets up a handler type.
      def self.setup_with_handler(*args)
        create_handler(@setup).curry.call(*args)
      end

      # Tears down a handler type.
      def self.teardown_with_handler(*args)
        create_handler(@teardown).curry.call(*args)
      end

      # Returns a unique name.
      def self.generate_name
        'ruby-instance'
      end

      # Reduce handler options based on if they are enabled.
      def self.reduce_handler_option
        proc do |(name, config), acc|
          acc[name] = config if handle? config

          acc
        end
      end

      # Given agent options, handlers options are returned.
      def self.filter_enabled_handler_options(options)
        options.each_with_object({}, &reduce_handler_option)
      end

      # Given agent options, handlers options are returned.
      def self.filter_handlers(options)
        options.each_with_object({}) do |(name, config), acc|
          acc[name] = filter_enabled_handler_options config

          acc
        end
      end

      # Determines if a handler configuration should be handled.
      def self.handle?(value)
        return value if value == true

        if Functional::TypeCheck::Type?(value, Hash) && (value.key? :enabled)
          return value[:enabled]
        end

        false
      end

      # Given an agent config a name will be returned.
      def self.resolve_name(config)
        return config[:name] if config.key?(:name) && !config[:name].nil?

        generate_name
      end
    end
  end
end
