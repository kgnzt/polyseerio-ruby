require 'concurrent'
require 'agent/helper'

# Agent executor functions.
module Executor
  #setup_handler    = Helper::setup_with_handler Handler
  #teardown_handler = Helper::teardown_with_handler Handler

  # Setsup a client agent.
  def setup(client, config)
    #Current::Promise.execute{}
  end

  # Tearsdown a client agent.
  def teardown(client, instance)
    #teardown_handler('event', {
      #stop: true
    #}, client, instance)
#
    #Current::Promise.execute{}
  end
end
