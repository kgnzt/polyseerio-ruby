require 'helper'
require 'sdk/helper'
require 'url_builder'

module Polyseerio
  module SDK
    # Static methods.
    module Static
      def self.remove
        proc do |request, resource, copts, id, options = {}|
          options = Polyseerio::Helper.defaults(options, copts)

          eid = Helper.resolve_eid options
          uri = URL.get_resource_path(resource, eid: eid, id: id)

          request.delete uri
        end
      end
    end
  end
end
