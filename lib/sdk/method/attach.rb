require 'concurrent'

module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.attach
        proc do ||
          uri = URL.get_resource_path(type, eid: eid, id: id)

          Concurrent::Promise.new do
            heartbeat_thread = Thread.new do
              loop do
                request.post("#{uri}/heartbeat", {}).execute.value
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
