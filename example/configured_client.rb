require 'polyseerio'
include Polyseerio::Enum

# Clients are configurable, see docs for all options.
client = Polyseerio.make(
  env: 'RUBY_ENV',
  token: 'my-secret-access-token',
  token_env: 'POLY_TOKEN',
  timeout: 5000
)

client.Instance.find_by_name(name: 'my-instance')
      .then(proc do |reason|
        puts "Could not find instance: #{reason.response}."
      end) do |instance|
        instance.fact('start_timestamp', Date.today.to_time.to_i)
      end.execute.value
