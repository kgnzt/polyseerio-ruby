require 'concurrent'
require 'helper'
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

            instance = client.Instance.find_by_name name: name.execute.value

            setup_handler('process_event', client)
            setup_handler('metric', client)
            setup_handler('event', client)

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
