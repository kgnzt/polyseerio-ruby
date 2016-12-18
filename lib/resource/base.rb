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
                 Polyseerio::SDK::Helper.resolve_eid(attributes)
               end
        @attributes = attributes
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

      private

      attr_accessor :attributes
      attr_writer :attributes
    end
  end
end
