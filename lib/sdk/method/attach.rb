require 'sdk/helper'
require 'concurrent'

module Polyseerio
  module SDK
    # Introduce methods.
    module Method
      def self.attach
        proc do |instance|
          uri = Helper.instance_to_uri instance

          Concurrent::Promise.new do
            heartbeat_thread = Thread.new(instance.request) do |req|
              loop do
                payload = {}

                if instance.respond_to? :_facts
                  payload[:facts] = instance._facts

                  instance._facts = Helper.remove_non_resolving_values(
                    instance._facts
                  )
                end

                if instance.respond_to? :_gauges
                  payload[:metrics] = {}
                  payload[:metrics][:gauges] = instance._gauges

                  instance._gauges = Helper.remove_non_resolving_values(
                    instance._gauges
                  )
                end

                req.post("#{uri}/heartbeat", payload).execute.value

                sleep(5)
              end
            end

            heartbeat_thread
          end
        end
      end
    end
  end
end
