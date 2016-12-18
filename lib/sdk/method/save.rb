require 'helper'
require 'sdk/helper'
require 'url_builder'

module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.save
        proc do |instance|
          uri = URL.get_resource_path(
            instance.type,
            eid: instance.eid,
            id: instance.id
          )

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
