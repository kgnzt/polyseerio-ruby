require 'sdk/helper'

module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.save
        proc do |instance|
          uri = Helper.instance_to_uri instance

          # TODO: need a way to make raw requests without middleware.
          # TODO: there is no reason to have to create another instance.
          if instance.new?
            instance.request.post(uri, instance.properties)
                    .then do |result|
                      instance.override_properties(result.properties)

                      instance
                    end
          else
            instance.request.put(uri, instance.properties)
                    .then do |result|
                      instance.override_properties(result.properties)

                      instance
                    end
          end
        end
      end
    end
  end
end
