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

            instance = Resource::Routine.upsert(
              client.Instance,
              name: name
            ).execute.value

            client.instance = instance

            # merge this with filter_handler below?
            handler_options = options.select do |key, _|
              Polyseerio::Agent::Handler::HANDLER.key? key
            end

            handler_options = Helper.filter_handlers handler_options

            setup_handler = Helper.setup_with_handler(
              Polyseerio::Agent::Handler::HANDLER,
              client,
              handler_options
            )

            # Gather the setups.
            setups = handler_options.map do |key, _config|
              setup_handler.call(key)
            end

            Concurrent::Promise.zip(*setups).execute.value

            # now attach
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
