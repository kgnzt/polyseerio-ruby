require 'resource'
require 'constant'
require 'helper'

# Main Polyseerio module.
module Polyseerio
  # Default options
  module Defaults
    # Default client options
    COPTS = {
      agent:      {},
      deduce:     true,
      env:        Constant::DEFAULT_ENV,
      timeout:    Constant::DEFAULT_TIMEOUT,
      token:      nil,
      token_env:  Constant::DEFAULT_TOKEN_ENV,
      upsert_env: true,
      version:    Constant::DEFAULT_API_VERSION
    }.freeze
  end

  # Resources required for a ruby polyseer.io Client
  module RequiredResources
    RESOURCES = [
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
  end

  # Maps resources to paths within a Client
  module ClientResourcePaths
    PATHS = {
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
  end

  def self.start(config)
    config
  end

  def self.make(options = Defaults::COPTS)
    token = Helper.resolve_token options

    # generate default options from passed an copts
    # resolve token, if unresolved raise
    # get base url and setup headers
    # create request object
    # create, pre, post, reject middle and wrap
    # create resources
    # generate client
    # return client
    headers = {
      Constant::ACCESS_TOKEN_HEADER => token
    }

    headers
  end
end
