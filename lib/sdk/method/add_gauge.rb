module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.add_gauge
        proc do |instance, key, value|
          instance.gauges ||= {}

          instance.gauges[key] = value
        end
      end
    end
  end
end
