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
            heartbeat_thread = Thread.new(instance) do |inst|
              begin
                loop do
                  payload = {}
  
                  inst.request.post("#{uri}/heartbeat", payload).execute.value
                  puts 'd'
  
                  sleep(5)
                end
              rescue => err
                puts err
              end
            end

            heartbeat_thread.join

            heartbeat_thread
          end
        end
      end
    end
  end
end
