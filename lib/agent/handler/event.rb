require 'agent/enum'

module Polyseerio
  module Agent
    # Introduces event handler.
    module Handler
      include Agent::Enum

      def self.event
        {
          Event::START => proc do |client, instance|
            client.Event.create(
              name: "#{instance.name} agent has started.",
              color: Polyseerio::Enum::Color::GREEN,
              icon: Polyseerio::Enum::Icon::CHAIN
            )
          end,

          Event::STOP => proc do |client, instance|
            client.Event.create(
              name: "#{instance.name} agent has stopped.",
              color: Polyseerio::Enum::Color::ORANGE,
              icon: Polyseerio::Enum::Icon::CHAIN_BROKER
            )
          end
        }
      end
    end
  end
end
