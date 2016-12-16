require 'agent/enum'

module Polyseerio
  module Agent
    # Introduce event handlers.
    module Handler
      include Agent::Enum

      def self.event
        {
          Event::START => proc do |_config, client|
            client.Event.create(
              name: "#{client.instance.name} agent has started.",
              color: Polyseerio::Enum::Color::GREEN,
              icon: Polyseerio::Enum::Icon::CHAIN
            )
          end,

          Event::STOP => proc do |_config, client|
            client.Event.create(
              name: "#{client.instance.name} agent has stopped.",
              color: Polyseerio::Enum::Color::ORANGE,
              icon: Polyseerio::Enum::Icon::CHAIN_BROKER
            )
          end
        }
      end
    end
  end
end
