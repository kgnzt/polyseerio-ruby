require 'polyseerio'

RSpec.describe Polyseerio do
  let(:client) { Polyseerio.make }

  it 'polyseerio can construct a client and agent at the same time' do
    expect { described_class.start }.not_to raise_error
  end

  it 'a client can start an agent' do
    expect { client.start_agent }.not_to raise_error
  end
end
