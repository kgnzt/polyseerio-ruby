module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.add_gauge
        proc do |instance, key, value|
          instance._gauges ||= {}

          instance._gauges[key] = value
        end
      end
    end
  end
end
