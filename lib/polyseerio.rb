require 'resource'

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
