require 'resource/definition'
require 'sdk/factory'
require 'inflection'

module Polyseerio
  module Resource
    # Resource building methods.
    module Factory
      # Determine if a resource definition represents a singleton.
      def self.defines_singleton?(definition)
        !definition.key?(:methods) || definition[:methods].empty?
      end

      # Add a static method to a Class.
      def self.add_static(*args)
        proc do |(name, method), resource|
          resource.class_eval do
            define_singleton_method(name, &method)
          end
        end.curry.call(*args)
      end

      # Add an instance method to a Class.
      def self.add_method(*args)
        proc do |(name, method), resource|
          resource.class_eval do
            # TODO: add forward_this aka forward resource? not sure
            define_method(name, &method)
          end
        end.curry.call(*args)
      end

      # Add a collection of static methods to a Class.
      def self.add_statics(resource, statics = {})
        return resource if statics.empty?

        statics.each_with_object(resource, &add_static)
      end

      # Add a collection of instance methods to a Class.
      def self.add_methods(resource, _request, methods = {})
        return resource if methods.empty?

        methods.each_with_object(resource, &add_method)
      end

      # Takes a resource name and creates a class name.
      def self.to_class_name(resource, cid = '')
        parts = resource.to_s.split('-').map(&:capitalize)

        parts[parts.size - 1] = Inflection.singular(parts.last)

        name = parts.join ''

        "#{name}#{cid}"
      end

      # Determine if a resource definition represents a singleton
      def self.create(resource, cid = '')
        Object.const_set(to_class_name(resource, cid), Class.new do
          @@resource = resource # rubocop:disable all
          attr_accessor :eid

          def initialize(attributes = {})
            @new = true
            @eid = attributes[:eid] || nil
            @attributes = attributes
          end

          def resource
            @@resource
          end

          def new?
            @new
          end

          def method_missing(name, *args, &block)
            @attributes.fetch(name) || super
          end

          def respond_to_missing?(method_name)
            if @attributes.key? method_name
              true
            else
              super
            end
          end

          private

          attr_accessor :new, :attributes
        end)
      end

      # Create a resource.
      def self.make(type, request, cid, options = {})
        unless Definition::DEFINITION.key? type
          raise ArgumentError, 'Could not find definition for resource: ' \
            "#{type}"
        end

        definition = Definition::DEFINITION.fetch(type)

        # Create the resource / class.
        resource = defines_singleton?(definition) ? {} : create(type, cid)

        # Add statics.
        if definition.key? Definition::STATICS
          statics = SDK::Static.factory(
            request,
            type,
            definition[Definition::STATICS],
            options
          )

          add_statics(resource, statics)
        end

        # Add methods.
        if definition.key? Definition::METHODS
          methods = SDK::Method.factory(
            request,
            type,
            definition[Definition::METHODS],
            options
          )

          add_methods(resource, request, methods)
        end

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
