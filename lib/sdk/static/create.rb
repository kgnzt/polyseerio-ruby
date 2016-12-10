module Polyseerio
  module SDK
    # Static methods.
    module Static
      def self.create
        proc do |request, resource, _, attributes, options|
          eid = resolve_eid options
          uri = get_resource_path(resource, eid: eid)

          request.post(uri, attributes)
        end
      end
    end
  end
end
