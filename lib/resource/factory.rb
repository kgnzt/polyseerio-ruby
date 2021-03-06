require 'resource/definition'
require 'resource/helper'
require 'resource/base'
require 'sdk/factory'
require 'inflection'
require 'sdk/helper'

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
            define_method(name, &Helper.forward_self(method))
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

      # Create a resource.
      # TODO: copts are not optional
      def self.create(type, request, cid, copts = {})
        resource = Object.const_set(to_class_name(type, cid), Class.new(Base))
        resource.define_singleton_method(:copts) do
          copts
        end

        resource.define_singleton_method(:type) do
          type
        end

        resource.define_singleton_method(:request) do
          request
        end

        resource.define_singleton_method(:cid) do
          cid
        end

        resource
      end

      # Create a resource.
      def self._make
        proc do |type, request, cid, options = {}|
          unless Definition::DEFINITION.key? type
            raise ArgumentError, 'Could not find definition for resource: ' \
              "#{type}"
          end

          definition = Definition::DEFINITION.fetch(type)

          # Create the resource / class.
          resource = if defines_singleton? definition
                       {}
                     else
                       create(type, request, cid, options)
                     end

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
      end

      # Generate a memoize key based on factory arguments
      def self.get_memoize_key(resource, _request, cid, _options = {})
        :"#{resource}_#{cid}"
      end

      # Convenience for get_memoize_key in proc form.
      def self.memoize_key
        proc do |*args|
          get_memoize_key(*args)
        end
      end

      # TODO: ideal API would be memoize(:make, memoize_key) - in future.
      @make = Polyseerio::Helper.memoize_function(_make, memoize_key)

      # Memoized calls to make. A little ugly, would like a better memoize API.
      def self.make(*args)
        @make.call(*args)
      end
    end
  end
end
