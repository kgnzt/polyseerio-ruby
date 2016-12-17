module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.add_fact
        proc do |key, value|
          self.facts ||= {}

          self.facts[key] = value
        end
      end
    end
  end
end
