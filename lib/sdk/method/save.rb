require 'helper'
require 'sdk/helper'
require 'url_builder'

module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.save
        proc do |instance, options|
          options = Polyseerio::Helper.defaults(options, copts)
          uri = URL.get_resource_path(resource, eid: instance.eid, id: instance.id)

          if instance.new?
            instance._request.post uri
          else
            instance._request.put uri
          end
        end
      end
    end
  end
end
