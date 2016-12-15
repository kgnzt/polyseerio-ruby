require 'concurrent'

module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.attach
        proc do ||
          Concurrent::Promise.new {}
        end
      end
    end
  end
end
