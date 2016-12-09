require 'agent/agent'
require 'helper'

# Polyseer.io client.
class Client
  INITIALIZE_DEFAULTS = {
    agent_class: Agent,
    request: nil
  }.freeze

  attr_accessor :cid, :agent

  def initialize(cid, options = {})
    options = Helper.defaults(options, INITIALIZE_DEFAULTS)

    # check for cid
    # check for request

    if options[:request].nil?
      raise ArgumentError, 'Cannot create an instance of Client without' \
        'passing a request instance.'
    end

    @cid = cid
    @agent = nil
    @request = options[:request]
    @agent_class = options[:agent_class]
  end

  # Start an agent using this client.
  def start_agent(*args)
    raise 'Agent has already started.' unless @agent.nil?

    @agent = @agent_class.new(self)

    @agent.start(*args)
  end

  private

  attr_accessor :request, :agent_class
end
