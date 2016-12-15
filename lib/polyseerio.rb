require 'resource'
require 'resource/factory'
require 'request'
require 'middleware'
require 'constant'
require 'enum'
require 'client'
require 'url_builder'
require 'rest-client'
require 'helper'

# Main Polyseerio module.
module Polyseerio
  # Default client options.
  DEFAULT_CLIENT_OPTIONS = {
    agent:      {},
    deduce:     true,
    env:        Constant::DEFAULT_ENV,
    timeout:    Constant::DEFAULT_TIMEOUT,
    token:      nil,
    token_env:  Constant::DEFAULT_TOKEN_ENV,
    upsert_env: true,
    version:    Constant::DEFAULT_API_VERSION
  }.freeze

  # Required resources for constructing a client.
  REQUIRED_RESOURCES = [
    Resource::ALERT,
    Resource::CHANNEL,
    Resource::ENVIRONMENT,
    Resource::EVENT,
    Resource::EXPECTATION,
    Resource::INSTANCE,
    Resource::LOGIC_BLOCK,
    Resource::MEMBER,
    Resource::SETTING,
    Resource::TASK
  ].freeze

  # Maps resources to paths within a Client
  CLIENT_RESOURCE_PATHS = {
    Resource::ALERT       => :Alert,
    Resource::CHANNEL     => :Channel,
    Resource::ENVIRONMENT => :Environment,
    Resource::EVENT       => :Event,
    Resource::EXPECTATION => :Expectation,
    Resource::INSTANCE    => :Instance,
    Resource::LOGIC_BLOCK => :LogicBlock,
    Resource::MEMBER      => :Member,
    Resource::SETTING     => :Settings,
    Resource::TASK        => :Task
  }.freeze

  # Create a client and start it's agent.
  def self.start(*args)
    client = make(*args)

    client.start_agent
  end

  @make_call_count = 0

  # Create a client.
  def self.make(options = {})
    options = Helper.defaults(options, DEFAULT_CLIENT_OPTIONS)

    cid = @make_call_count

    token = Helper.resolve_token options

    base_url = URL.get_base_url(
      Constant::DEFAULT_API_BASE_URL,
      Constant::DEFAULT_API_PROTOCOL,
      options[:version]
    )

    if token.nil?
      raise ArgumentError, 'Could not find an access token. None was passed' \
        'and non could be found in the environment variable: ' \
        "#{options[:token_env]}."
    end

    headers = {
      Constant::ACCESS_TOKEN_HEADER => token,
      :content_type => 'application/json'
    }

    rest_resource = RestClient::Resource.new(
      base_url,
      headers: headers,
      timeout: options[:timeout]
    )

    # Create a request instance that uses middleware.
    request = Request.new(
      rest_resource,
      pre: [Middleware::Pre.format_arguments],
      post: [Middleware::Post.to_response, Middleware::Post.parse_response]
    )

    resources = REQUIRED_RESOURCES.each_with_object({}) do |resource, acc|
      acc[resource] = Resource::Factory.make(resource, request, cid, options)

      acc
    end

    resources = Helper.rekey(resources, CLIENT_RESOURCE_PATHS)

    client = Client.new(cid, request: request, resources: resources)

    @make_call_count += 1

    client
  end
end
