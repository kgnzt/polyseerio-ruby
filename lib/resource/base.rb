require 'sdk/helper'

module Polyseerio
  module Resource
    # Base class for any resource.
    class Base
      attr_accessor :eid
      attr_writer :eid

      def initialize(attributes = {})
        @eid = if attributes.include? :eid
                 attributes[:eid]
               else
                 Polyseerio::SDK::Helper.resolve_eid(copts)
               end
        @attributes = attributes
      end

      # Set a property hash on the instance.
      def override_properties(properties)
        properties.each_with_object(self) do |(key, value), this|
          this.send(:"#{key}=", value)
        end
      end

      # Returns a copy of class attributes.
      def properties
        attributes.clone
      end

      # Returns the type of the class.
      def type
        self.class.type
      end

      # Returns the client options this class was constructed with.
      def copts
        self.class.copts
      end

      # Returns the client's request object.
      def request
        self.class.request
      end

      # True if the resource is new (not yet saved).
      def new?
        id.nil?
      end

      # TODO: move towards this
      def get(key, default = nil)
        @attributes.fetch(key, default)
      end

      # TODO: move towards this
      def set(key, value)
        @attributes[key] = value
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

      def respond_to_missing?(method_name)
        !methods.include(method_name)
      end

      private

      attr_accessor :attributes
      attr_writer :attributes
    end
  end
end
