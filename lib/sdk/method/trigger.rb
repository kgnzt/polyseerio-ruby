require 'sdk/helper'

module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.trigger
        proc do |instance, payload = {}|
          # raise if the instance has not been saved yet...
          uri = Helper.instance_to_uri instance

          instance.request.post("#{uri}/trigger", payload)
        end
      end
    end
  end
end
