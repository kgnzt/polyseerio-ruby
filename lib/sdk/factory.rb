require 'sdk/static/index'
require 'sdk/method/index'
require 'sdk/helper'

module Polyseerio
  module SDK
    # SDK static module.
    module Static
      # Generates static functions.
      def self.factory(_request, _resource, statics = [], _options = {})
        statics.each_with_object({}, &Helper.accumulate_procs('static', MAP))
      end
    end

    # SDK Method (instance) module.
    module Method
      # Generates method (instance) functions.
      def self.factory(_request, _resource, methods = [], _options = {})
        methods.each_with_object({}, &Helper.accumulate_procs('method', MAP))
      end
    end
  end
end
