module Polyseerio
  module SDK
    # Instance methods.
    module Method
      def self.trigger
        proc do |instance, payload = {}|
          # raise if the instance has not been saved yet...
          uri = URL.get_resource_path(
            instance.type,
            eid: instance.eid,
            id: instance.id
          )

          instance.request.post("#{uri}/trigger", payload)
        end
      end
    end
  end
end
