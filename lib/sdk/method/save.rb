require 'sdk/helper'

module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.save
        proc do |instance|
          uri = Helper.instance_to_uri instance

          if instance.new?
            instance.request.post(uri, instance.attributes)
          else
            instance.request.put(uri, instance.attributes)
          end
        end
      end
    end
  end
end
