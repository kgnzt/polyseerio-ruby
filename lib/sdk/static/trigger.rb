module Polyseerio
  module SDK
    # Static methods.
    module Static
      def self.trigger
        proc do |request, resource, copts, id, payload = {}, options = {}| # rubocop:disable all
          options = Polyseerio::Helper.defaults(options, copts)

          eid = Helper.resolve_eid options
          uri = URL.get_resource_path(resource, eid: eid, id: id)

          request.post("#{uri}/trigger", payload)
        end
      end
    end
  end
end
