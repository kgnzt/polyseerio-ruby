require 'enum'

module Polyseerio
  # Defines polyseer.io resources
  module Resource
    module Definition
      STATICS = :statics
      METHODS = :methods

      CREATABLE_STATICS = [
        :create
      ].freeze
      READABLE_STATICS = [
        :find,
        :find_by_id
      ].freeze
      DELETABLE_STATICS = [
        :remove
      ].freeze
      UPDATABLE_STATICS = [
        :update
      ].freeze
      CRUD_STATICS = [
        *CREATABLE_STATICS,
        *READABLE_STATICS,
        *DELETABLE_STATICS,
        *UPDATABLE_STATICS
      ].freeze

      RESOURCE_INSTANCE = [
        :to_json
      ].freeze

      SAVABLE_INSTANCE = [
        :save
      ].freeze

      DEFINITION = {
        Enum::Resource::ALERT => {
          STATICS => [
            *CRUD_STATICS,
            :find_by_name,
            :trigger
          ],
          METHODS => [
            *SAVABLE_INSTANCE,
            *RESOURCE_INSTANCE,
            :trigger,
            :remove
          ]
        },
        Enum::Resource::CHANNEL => {
          STATICS => [
            *CRUD_STATICS,
            :find_by_name,
            :message
          ],
          METHODS => [
            *SAVABLE_INSTANCE,
            *RESOURCE_INSTANCE,
            :message,
            :remove
          ]
        },
        Enum::Resource::ENVIRONMENT => {
          STATICS => [
            *CRUD_STATICS,
            :find_by_name,
            :message
          ],
          METHODS => [
            *SAVABLE_INSTANCE,
            *RESOURCE_INSTANCE,
            :message,
            :remove
          ]
        },
        Enum::Resource::EVENT => {
          STATICS => [
            *CREATABLE_STATICS,
            *READABLE_STATICS
          ],
          METHODS => [
            *SAVABLE_INSTANCE,
            *RESOURCE_INSTANCE
          ]
        },
        Enum::Resource::EXPECTATION => {
          STATICS => [
            *CRUD_STATICS,
            :find_by_name,
            :check
          ],
          METHODS => [
            *SAVABLE_INSTANCE,
            *RESOURCE_INSTANCE,
            :remove,
            :check
          ]
        },
        Enum::Resource::INSTANCE => {
          STATICS => [
            *CRUD_STATICS,
            :find_by_name,
            :attach
          ],
          METHODS => [
            *SAVABLE_INSTANCE,
            *RESOURCE_INSTANCE,
            :set_fact,
            :gauge,
            :add_gauge,
            :attach,
            :detach,
            :remove
          ]
        },
        Enum::Resource::LOGIC_BLOCK => {
          STATICS => [
            *CRUD_STATICS,
            :execute
          ],
          METHODS => [
            *SAVABLE_INSTANCE,
            *RESOURCE_INSTANCE,
            :remove,
            :execute
          ]
        },
        Enum::Resource::MEMBER => {
          STATICS => [
            *CRUD_STATICS
          ],
          METHODS => [
            *SAVABLE_INSTANCE,
            *RESOURCE_INSTANCE,
            :remove
          ]
        },
        Enum::Resource::MESSAGE => {
          STATICS => [
            *CRUD_STATICS
          ],
          METHODS => [
            *SAVABLE_INSTANCE,
            *RESOURCE_INSTANCE
          ]
        },
        Enum::Resource::SETTING => {
          STATICS => []
        },
        Enum::Resource::TASK => {
          STATICS => [
            *CRUD_STATICS
          ],
          METHODS => [
            *SAVABLE_INSTANCE,
            *RESOURCE_INSTANCE,
            :remove
          ]
        }
      }.freeze
    end
  end
end
