require 'helper'
require 'concurrent'

module Polyseerio
  # HTTP response wrapper.
  class Response
    def initialize(rest_response)
      @rest_response = rest_response
    end

    # Returns the response body.
    #
    # NOTE: This function is memoized.
    def body
      @body_result ||= JSON.parse(@rest_response.body, symbolize_names: true)
    end

    # Returns the original request obect.
    def request
      @rest_response.request
    end

    private

    attr_accessor :rest_response
  end
end
