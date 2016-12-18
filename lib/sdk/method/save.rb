require 'sdk/helper'

module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.save
        proc do |instance|
          uri = Helper.instance_to_uri instance

          if instance.new?
            instance.request.post(uri, instance.properties)
          else
            instance.request.put(uri, instance.properties)
          end
        end
      end
    end
  end
end
