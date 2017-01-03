require 'polyseerio'

# Create a client that has some custom configuration.
client = Polyseerio.make(
  env: 'RUBY_ENV',
  token: 'my-secret-access-token',
  token_env: 'POLY_TOKEN',
  timeout: 5000
)

# We can now make SDK calls using our configured client instance.
client.Instance.find_by_name('my-instance')
      .then(proc do |reason|
        puts "Could not find instance: #{reason.http_code} -- #{reason.response}."
      end) do |instance|
        puts "Found instance: #{instance.id}. Updating instance facts."

        instance.fact('start_timestamp', Date.today.to_time.to_i)
      end.execute.value
