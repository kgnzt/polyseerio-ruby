require 'agent/executor'

# Polyseer.io Ruby agent.
class Agent
  def initialize(client)
    @client = client
  end

  def start(**args)
    # @instance = Executor.setup(client, *args)

    # @client
  end

  def stop
    Executor.teardown(client, instance)
  end
end
