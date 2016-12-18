module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.add_fact
        proc do |instance, key, value|
          instance.facts ||= {}

          instance.facts[key] = value
        end
      end
    end
  end
end
