require 'resource/definition'
require 'sdk/factory'

module Polyseerio
  module Resource
    # Resource building methods.
    module Factory
      # Determine if a resource definition represents a singleton
      def self.singleton_definition?(definition)
        !definition.key?(:methods) || definition[:methods].empty?
      end

      # Add a static method to a Class
      def self.add_static(resource, method, name)
        resource.class_eval do
          define_singleton_method(name, &method)
        end
      end

      # Add an instance method to a Class
      def self.add_method(resource, method, name)
        resource.class_eval do
          define_method(name, &method)
        end
      end

      # Add a collection of static methods to a Class
      def self.add_statics(resource, statics = [])
        return resource if statics.empty?

        statics.reduce(resource, &add_static)
      end

      # Add a collection of instance methods to a Class
      def self.add_methods(resource, methods = [])
        return resource if methods.empty?

        methods.reduce(resource, &add_method)
      end

      # Determine if a resource definition represents a singleton
      def self.create(resource)
        Object.const_set(resource, Class.new do
          attr_accessor :eid

          def initialize(attributes = {})
            @new = true
            @eid = attributes[:eid] || nil
          end

          def type
            self.class.name
          end

          def new?
            @new
          end

          private

          attr_accessor :new, :attributes
        end)
      end

      # Create a resource.
      def self.make(resource, request, _cid, options = {})
        unless Definition::DEFINITION.key? resource
          raise ArgumentError, 'Could not find definition for resource: ' \
            "#{resource}"
        end

        definition = Definition::DEFINITION.fetch(resource)

        resource = singleton_definition?(definition) ? {} : create(resource)

        statics = SDK::Static.factory(
          request,
          resource,
          definition[Definition::STATICS],
          options
        )
        methods = SDK::Static.factory(
          request,
          resource,
          definition[Definition::METHODS],
          options
        )

        add_statics(resource, statics)
        add_methods(resource, request, methods)

        resource
      end

      # Generate a memoize key based on factory arguments
      def self.get_memoize_key(resource, _, cid, _)
        "#{resource}.#{cid}"
      end

      # memoize(:factory?)
    end
  end
end
