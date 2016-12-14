require 'resource'

module Polyseerio
  module SDK
    # Static methods.
    module Static
      def self.find_by_name
        proc do |request, resource, _, name, options = {}|
          name = "/name/#{name}"
          eid = Helper.resolve_eid options

          uri = URL.get_resource_path(resource, eid: eid)

          uri = if resource == Polyseerio::Resource::ENVIRONMENT
                  "/environments#{name}"
                else
                  "#{uri}#{name}"
                end

          request.get uri
        end
      end
    end
  end
end
