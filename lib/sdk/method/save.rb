require 'helper'
require 'sdk/helper'
require 'url_builder'

module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.save
        proc do ||
          uri = URL.get_resource_path(type, eid: eid, id: id)

          if new?
            request.post(uri, @attributes)
          else
            request.put(uri, @attributes)
          end
        end
      end
    end
  end
end
