require 'helper'

# Request middleware.
module Middleware
  def self.pre_request
    proc do |options|
      options = options.clone

      if options.key? :body
        options[:body] = Helper.format_payload options[:body]
      end

      options
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
