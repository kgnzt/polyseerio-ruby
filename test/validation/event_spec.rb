require 'polyseerio'

RSpec.describe Polyseerio do
  let(:client) { Polyseerio.make }
  let(:event) { client.Event }

  it 'can create an event' do
    event.create name: 'alpha'
  end
end
