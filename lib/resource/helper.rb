module Polyseerio
  module Resource
    # Helper methods for building and working with resources
    module Helper
      EID_REGEX = Regexp.new('/environments/([\da-z\.-]+)/')

      # Forward self as first argument. Used for method procs.
      def self.forward_self(func)
        proc do |*args|
          func.call(self, *args)
        end
      end

      # Given a request path an eid is returned or nil
      def self.get_eid_from_resource_path(path)
        result = EID_REGEX.match path

        return result if result.nil?

        result[1]
      end

      # True if the response is a resource based response
      def self.resource_response?(body)
        body.key?(:data) &&
          (resource?(body[:data]) || resource_collection?(body[:data]))
      end

      # True if response data is a resource collection (alias)
      def self.resource_collection?(data)
        data.is_a? Array
      end

      # True if response data is a resource collection (alias)
      def self.resource?(data)
        data.is_a? Hash
      end

      # Convert parsed response data into an instance
      # TODO: hard to unit-test (due to Factory.make)
      def self.to_instance(data, _meta, _included, cid)
        type = data.fetch(:type, nil)
        id = data.fetch(:id, nil)
        attributes = data.fetch(:attributes, {})

        attributes[:id] = id

        # parse_response would only eve be called once the client has been
        # constructed meaning in order to get the class we simply need to
        # pass the type and cid. make is memoized on the type and cid args.
        resource = Factory.make(type, nil, cid)

        resource.new(attributes) # TODO: need to include meta
      end

      # Parse a resource response
      # TODO: hard to unit-test (due to Factory.make)
      def self.parse_resource_response(response, cid)
        body = response.body
        meta = body[:meta] || {}
        included = body[:included] || {}
        data = body[:data]

        eid = get_eid_from_resource_path response.request.uri.path

        # attach eid if we have attributes and an id
        # would need to occur for each?????
        data[:attributes][:eid] = eid if !eid.nil? && data.key?(:attributes)

        # if resource collection if so map return
        if resource_collection? data
          return data.map do |item|
            to_instance(item, meta, included, cid)
          end
        end

        # convert to instance
        to_instance(data, meta, included, cid)
      end

      # Parse a response
      def self.parse_response(response, cid)
        if resource_response? response.body
          return parse_resource_response(response, cid)
        end

        response
      end
    end
  end
end
