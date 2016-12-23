module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.add_fact
        proc do |instance, key, value|
          # TODO: should be something other than facts
          instance._facts ||= {}

          instance._facts[key] = value
        end
      end
    end
  end
end
