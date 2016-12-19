require 'helper'

module Polyseerio
  module Resource
    # Reusable resource routines.
    module Routine
      DEFAULT_UPSERT_OPTIONS = {
        key: :name
      }.freeze

      # Upsert a resource.
      def self.upsert(resource, attributes)
        unless attributes.key? :name
          raise ArgumentError, 'Passed attributes must contain a name.'
        end

        resource.find_by_name(attributes[:name])
                .then(proc do |reason|
                  raise reason if reason.http_code != 404

                  resource.create(attributes).execute.value
                end)
      end
    end
  end
end
