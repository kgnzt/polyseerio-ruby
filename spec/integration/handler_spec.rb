require 'polyseerio'
require 'agent/handler/index'

RSpec.describe Polyseerio::Agent::Handler::MAP do
  it 'event' do
    expect(described_class).to have_key(:event)
  end

  it 'expectation' do
    expect(described_class).to have_key(:expectation)
  end

  it 'metric' do
    expect(described_class).to have_key(:metric)
  end

  it 'process' do
    expect(described_class).to have_key(:process)
  end

  it 'fact' do
    expect(described_class).to have_key(:fact)
  end
end
