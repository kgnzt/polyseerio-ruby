require 'helper'

# HTTP request wrapper that can use attached middleware.
class Request
  module Middleware
    PRE    = :pre
    POST   = :post
    REJECT = :reject
  end

  INITIALIZE_DEFAULTS = {
    Middleware::PRE    => [],
    Middleware::POST   => [],
    Middleware::REJECT => []
  }.freeze

  def initialize(resource, options = {})
    # need to ensure taht pre, post, reject are all arrays otherwise raise
    options = Helper.defaults(options, INITIALIZE_DEFAULTS)

    @resource = resource

    @pre_request    = options[Middleware::PRE]
    @post_request   = options[Middleware::POST]
    @reject_request = options[Middleware::REJECT]
  end

  # Perform a GET request.
  def get(*args)
    execute(:get, *args)
  end

  # Perform a POST request.
  def post(*args)
    execute(:post, *args)
  end

  # Perform a PUT request.
  def put(*args)
    execute(:put, *args)
  end

  # Perform a DELETE request.
  def delete(*args)
    execute(:delete, *args)
  end

  private

  # Execute a request using pre, post, and reject middleware.
  def execute(method, *args)
    new_args = args

    @pre_request.each do |middleware|
      new_args = middleware.call(*new_args)
    end

    path = new_args.size > 1 ? new_args.shift : ''

    result = @resource[path].send(method, *new_args)

    @post_request.each do |middleware|
      result = middleware.call(result)
    end

    result
  end

  attr_accessor :resource, :pre_request, :post_request, :reject_request
end
