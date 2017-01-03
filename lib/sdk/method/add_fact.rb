module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.add_fact
        proc do |instance, key, value|
          instance._facts ||= {}

          instance._facts[key] = value
        end
      end
    end
  end
end
