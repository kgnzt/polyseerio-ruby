require 'polyseerio'

RSpec.describe Polyseerio do
  it 'pending' do
    client = Polyseerio.make

    Agent = client.Event

    puts Agent.new

    # client.dork

    # p = client.Event.find_by_name 'ding-dong'

    # p.execute
  end
end
