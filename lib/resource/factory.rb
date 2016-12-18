require 'resource/definition'
require 'resource/helper'
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

      # Determine if a resource definition represents a singleton
      # TODO: Make this its own file / class use extend?
      # TODO: CID should not be optional, options should not be optional
      # TODO: unit-test this mess more
      def self.create(type, request, cid = '', options = {})
        result = Object.const_set(to_class_name(type, cid), Class.new do
          # TODO: unit-test that this is attached
          @@resource = type # rubocop:disable all
          @@request = request # rubocop:disable all
          @@options = options # rubocop:disable all
          attr_accessor :eid

          def initialize(attributes = {})
            @new = true
            # TODO: unit-test this eid
            @eid = if attributes.include? :eid
                     attributes[:eid]
                   else
                     Polyseerio::SDK::Helper.resolve_eid(options)
                   end
            @attributes = attributes
          end

          def resource
            @@resource
          end

          def options
            @@options
          end

          def request
            @@request
          end

          def new?
            id.nil?
          end

          def method_missing(name, *args) # rubocop:disable all
            # Setter.
            if name =~ /^(\w+)=$/
              name = :"#{$1}" # rubocop:disable all

              @attributes[:"#{$1}"] = args[0] # rubocop:disable all
            end

            # Getter.
            @attributes.fetch(name, nil)
          end

          def respond_to_missing?(_method_name)
            true
          end

          # TODO: unit-test
          def type
            self.class.type
          end

          attr_accessor :new, :attributes
        end)

        # TODO: unit-test
        result.define_singleton_method(:type) do
          type
        end

        result
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
