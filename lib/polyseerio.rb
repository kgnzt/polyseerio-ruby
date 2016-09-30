require 'resource'
require 'constant'

# Default options
module Defaults
  # Default client options
  COPTS = {
    env: Constant::DEFAULT_ENV,
    version: Constant::DEFAULT_API_VERSION,
    deduce: true
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

module Factory
  def self.make(token, options = Defaults::COPTS)
    headers = {
      Constant::ACCESS_TOKEN_HEADER => token
    }

    nil
  end
end
