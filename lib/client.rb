# Polyseer.io client
class Client
  attr_reader :cid

  def initialize(cid, options = {})
    # check for cid
    # check for request

    unless options.key? :request || options[:request].nil?
    end

    self.cid = cid
    @request = options[:request]
  end

  def start_agent(**args)
    @agent = new Agent(self)

    @agent.start(*args)
  end

  def stop_agent
  end

  private

  attr_reader :_request
  attr_writer :cid
end
