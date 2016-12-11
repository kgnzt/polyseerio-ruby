require 'sdk/helper'
require 'url_builder'

module Polyseerio
  module SDK
    # Static methods.
    module Static
      def self.find_by_id
        proc do |request, resource, _, id, options = {}|
          eid = Helper.resolve_eid options
          uri = URL.get_resource_path(resource, eid: eid, id: id)

          request.get uri
        end
      end
    end
  end
end
