require 'polyseerio'

module Helpers
  module Validation
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

    # Generates a unique name.
    def self.unique_name
    end
  end
end
