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
                req.post("#{uri}/heartbeat", {}).execute.value
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
