require 'agent/executor'

module Polyseerio
  module Agent
    # Polyseer.io Ruby agent.
    class Agent
      attr_accessor :client, :instance

      def initialize(client)
        @client = client
      end

      # Starts the agent.
      def start(*args)
        @instance = Executor.setup(client, *args)

        client
      end

      # Stops the agent.
      def stop
        Executor.teardown(client, instance).then do
          @instance = nil
        end
      end

      private

      attr_writer :client, :instance
    end
  end
end
