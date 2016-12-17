require 'agent/handler/interface'

RSpec.describe Polyseerio::Agent::Handler::Interface do
  it 'defines SETUP' do
    expect(described_class::SETUP).to eq(:setup)
  end

  it 'defines TEARDOWN' do
    expect(described_class::TEARDOWN).to eq(:teardown)
  end
end
