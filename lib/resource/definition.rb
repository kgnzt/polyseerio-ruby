require 'resource'

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
        Resource::ALERT => {
          STATICS => [
            *CRUD_STATICS,
            :find_by_name,
            :trigger
          ],
          METHODS => [
          ]
        },
        Resource::CHANNEL => {
          STATICS => [
            *CRUD_STATICS,
            :find_by_name,
            :message
          ],
          METHODS => [
          ]
        },
        Resource::ENVIRONMENT => {
          STATICS => [
            *CRUD_STATICS,
            :find_by_name,
            :message
          ],
          METHODS => [
          ]
        },
        Resource::EVENT => {
          STATICS => [
            *CREATABLE_STATICS,
            *READABLE_STATICS
          ],
          METHODS => [
          ]
        },
        Resource::EXPECTATION => {
          STATICS => [
            *CRUD_STATICS,
            :find_by_name,
            :check
          ],
          METHODS => [
          ]
        },
        Resource::INSTANCE => {
          STATICS => [
            *CRUD_STATICS,
            :find_by_name,
            :attach
          ],
          METHODS => [
          ]
        },
        Resource::LOGIC_BLOCK => {
          STATICS => [
            *CRUD_STATICS,
            :execute
          ],
          METHODS => [
          ]
        },
        Resource::MEMBER => {
          STATICS => [
            *CRUD_STATICS
          ],
          METHODS => [
          ]
        },
        Resource::MESSAGE => {
          STATICS => [
            *CRUD_STATICS
          ],
          METHODS => [
          ]
        },
        Resource::SETTING => {
          STATICS => [],
          METHODS => [
          ]
        },
        Resource::TASK => {
          STATICS => [
            *CRUD_STATICS
          ],
          METHODS => [
          ]
        }
      }.freeze
    end
  end
end
