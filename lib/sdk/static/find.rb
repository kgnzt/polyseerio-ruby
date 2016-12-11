require 'sdk/helper'
require 'url_builder'

module Polyseerio
  module SDK
    # Static methods.
    module Static
      def self.find
        # TODO; issue with arg arity on curry when all optional
        proc do |request, resource, _copts, _query, options = {}|
          eid = Helper.resolve_eid options
          uri = URL.get_resource_path(resource, eid: eid)

          # TODO: add query string
          request.get uri
        end
      end
    end
  end
end
