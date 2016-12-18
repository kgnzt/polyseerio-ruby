module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.add_gauge
        proc do |key, value|
          self.gauges ||= {}

          self.gauges[key] = value
        end
      end
    end
  end
end
