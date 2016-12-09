require 'helper'
require 'json'

# Request middleware. Arity in must match arity [array] out.
module Middleware
  def self.pre_request
    proc do |*args|
      new_args = args

      if new_args.size > 1
        new_args[1] = Helper.format_payload new_args[1]
        new_args[1] = new_args[1].to_json
      end

      new_args
    end
  end

  def self.post_request
    proc do |response|
      response
    end
  end

  def self.reject
    proc do |error|
    end
  end
end
