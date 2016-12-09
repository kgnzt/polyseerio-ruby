# Polyseer.io client
class Client
  attr_accessor :cid, :agent

  def initialize(cid, options = {})
    # check for cid
    # check for request

    unless (options.key? :request) && !options[:request].nil?
      raise ArgumentError, 'Cannot create an instance of Client without' \
        'passing a request instance.'
    end

    self.cid = cid
    self.agent = nil
    self.request = options[:request]
  end

  def start_agent(**args)
    @agent = new Agent(self)

    @agent.start(*args)
  end

  def stop_agent
  end

  private

  attr_accessor :request
end
