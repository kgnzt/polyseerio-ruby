require 'concurrent'
require 'helper'
require 'resource/routine'
require 'agent/handler/index'
require 'agent/helper'
require 'agent/default_config'

module Polyseerio
  module Agent
    # Agent executor functions.
    module Executor
      # Setsup a client's agent.
      def self.setup(client, options = {})
        options = Polyseerio::Helper.defaults(options, DEFAULT_CONFIG)

        Concurrent::Promise.new do
          if options[:attach]
            name = Helper.resolve_name(options)

            # Resolve the instance.
            # TODO: better handle failure to upsert.
            instance = Resource::Routine.upsert(
              client.Instance,
              name: name
            ).execute.value

            # Set the client's instance.
            client.instance = instance

            # Create a setup handler.
            handler_options = Helper.extract_handler_options options
            setup_handler = Helper.setup_with_handler(
              Polyseerio::Agent::Handler::MAP,
              client,
              handler_options
            )

            # Gather setup operations.
            setups = handler_options.map { |key, _| setup_handler.call(key) }

            # Perform setups.
            Concurrent::Promise.zip(*setups).execute.value

            # Start monitoring.
            instance.attach.execute.value

            instance
          end
        end
      end

      # Tearsdown a client's agent.
      def self.teardown(client, instance)
        Concurrent::Promise.new do
          teardown_handler('event', client)

          instance.detach.excecute.value
        end
      end
    end
  end
end
