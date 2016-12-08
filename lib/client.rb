# Polyseer.io client
class Client
  attr_reader :cid

  def initialize(cid, options = {})
    # check for cid
    # check for request

    @cid = cid;
    @request = cid;
  end

  def start_agent(**args)
   # check if there is already an agent attached

    @agent = new Agent(self);

    return @agent.start(*args);
  end

  def stop_agent()
  end

  private

  attr_reader :_request
  attr_writer :cid
end
