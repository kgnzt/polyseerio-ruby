module Polyseerio
  module SDK
    # Static methods.
    module Static
      def self.update
        # TODO: unit-test
        proc do |request, resource, copts, id, updates = {}, options = {}| # rubocop:disable all
          options = Polyseerio::Helper.defaults(options, copts)

          eid = Helper.resolve_eid options
          uri = URL.get_resource_path(resource, eid: eid, id: id)

          request.put(uri, updates)
        end
      end
    end
  end
end
