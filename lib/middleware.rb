require 'helper'
require 'json'
require 'response'
require 'resource/helper'

module Polyseerio
  module Middleware
    # Pre request middleware.
    module Pre
      # Requests arguments run through there.
      def self.format_arguments
        proc do |*args|
          new_args = args

          if new_args.size > 1
            new_args[1] = Helper.format_payload new_args[1]
            new_args[1] = new_args[1].to_json
          end

          new_args
        end
      end
    end

    # Post request middleware.
    module Post
      # Takes rest-client and response and converts it to internal response.
      def self.to_response
        proc do |response|
          Response.new(response)
        end
      end

      # Request results run through there.
      def self.parse_response
        proc do |response|
          Resource::Helper.parse_response(response, 0) # TODO: need a cid
        end
      end
    end

    # Request rejection (error) middleware.
    module Reject
      def self.handle_rejection
        proc do |error|
          error
        end
      end
    end
  end
end
