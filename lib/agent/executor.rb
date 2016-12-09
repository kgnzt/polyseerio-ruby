require 'concurrent'
require 'agent/helper'

# Agent executor functions.
module Executor
  # Setsup a client agent.
  def setup(client, config)
    Concurrent::Promise.resolve(client, config)
  end

  # Tearsdown a client agent.
  def teardown(client, instance)
    Concurrent::Promise.resolve(client, instance)
  end
end
