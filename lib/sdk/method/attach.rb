require 'sdk/helper'
require 'concurrent'
require 'constant'

module Polyseerio
  module SDK
    # Introduce methods.
    module Method
      def self.attach
        proc do |instance|
          options = Polyseerio::Helper.defaults(
            {},
            delay: Constant::DEFAULT_HEARTBEAT_DELAY
          )

          uri = Helper.instance_to_uri instance

          options[:delay] = Polyseerio::Helper.ms_to_seconds options[:delay]

          Concurrent::Promise.new do
            heartbeat_thread = Thread.new(instance, options) do |inst, opts|
              begin
                loop do
                  payload = {}

                  Polyseerio.log 'debug', 'Sending heartbeat.'
                  inst.request.post("#{uri}/heartbeat", payload).execute.value

                  sleep(opts[:delay])
                end
              rescue => err
                Polyseerio.log 'error', 'Heartbeat failed.'
                Polyseerio.log 'error', err.message
              end
            end

            heartbeat_thread
          end
        end
      end
    end
  end
end
