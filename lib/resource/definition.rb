require 'resource'

# Defines polyseer.io resources
module ResourceDefinition
  STATICS = :statics
  METHODS = :methods

  CREATABLE_STATICS = ['create']

  DEFINITION = {
    Resource::ALERT => {
      STATICS => [],
      METHODS => []
    },
    Resource::CHANNEL => {
      STATICS => [],
      METHODS => []
    },
    Resource::ENVIRONMENT => {
      STATICS => [],
      METHODS => []
    },
    Resource::EVENT => {
      STATICS => [],
      METHODS => []
    },
    Resource::EXPECTATION => {
      STATICS => [],
      METHODS => []
    },
    Resource::INSTANCE => {
      STATICS => [],
      METHODS => []
    },
    Resource::LOGIC_BLOCK => {
      STATICS => [],
      METHODS => []
    },
    Resource::MEMBER => {
      STATICS => [],
      METHODS => []
    },
    Resource::MESSAGE => {
      STATICS => [],
      METHODS => []
    },
    Resource::SETTING => {
      STATICS => [],
      METHODS => []
    },
    Resource::TASK => {
      STATICS => [],
      METHODS => []
    }
  }.freeze
end
