require 'polyseerio'
require 'date'

module Helpers
  module Validation
    NAME_PREFIX = 'ruby-sdk-validation-'.freeze

    # Validation testing environment.
    TEST_ENVIRONMENT = {
      name: 'validaton-testing-ruby',
      description: 'Ruby SDK validation test environment.'
    }.freeze

    # Default options for validation testing client.
    DEFAULT_CLIENT_OPTIONS = {
      deduce: false,
      environment: TEST_ENVIRONMENT[:name],
      upsert_env: false
    }.freeze

    # Assert that a promise has been fulfilled.
    def self.fulfilled?
    end

    # Assert that a promise has been rejected.
    def self.rejected?
    end

    # Ensure that an environment exists given its name.
    def self.ensure_environment(environment, data)
      remove_environment(environment, data).then(proc do |_|
        environment.find_by_name(data[:name])
      end) do |_|
        environment.create(data).execute.value
      end
    end

    # Remove an environment given its name.
    def self.remove_environment(environment, data)
      environment.find_by_name(data[:name]).then(proc { |_| nil }) do |result|
        environment.remove(result.id)
      end
    end

    # Setup validation testing.
    def self.setup(client)
      ensure_environment(client.Environment, TEST_ENVIRONMENT).then do |_|
        client
      end.execute.value
    end

    # Create a validation test client with default arguments.
    def self.client
      # TODO: merge opts
      Polyseerio.make(DEFAULT_CLIENT_OPTIONS)
    end

    # Teardown validation testing.
    def self.teardown(client)
      remove_environment(client.Environment, TEST_ENVIRONMENT).execute.value
    end

    @unique_name_calls = 0

    # Generates a unique name.
    def self.unique_name
      @unique_name_calls += 1

      "#{NAME_PREFIX}#{@unique_name_calls}-#{DateTime.now.strftime('%Q')}"
    end
  end
end
