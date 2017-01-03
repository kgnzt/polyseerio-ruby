require 'constant'

RSpec.describe Polyseerio::Constant do
  it 'defines ACCESS_TOKEN_HEADER' do
    expect(described_class::ACCESS_TOKEN_HEADER).to eq('X-AUTH-HEADER')
  end

  it 'defines DEFAULT_API_BASE_URL' do
    expect(described_class::DEFAULT_API_BASE_URL).to eq(
      'api.polyseer.io/polyseer'
    )
  end

  it 'defines DEFAULT_API_PROTOCOL' do
    expect(described_class::DEFAULT_API_PROTOCOL).to eq('https://')
  end

  it 'defines DEFAULT_API_VERSION' do
    expect(described_class::DEFAULT_API_VERSION).to eq('v1')
  end

  it 'defines DEFAULT_ENV' do
    expect(described_class::DEFAULT_ENV).to eq('RAILS_ENV')
  end

  it 'defines DEFAULT_ENVIRONMENT' do
    expect(described_class::DEFAULT_ENVIRONMENT).to eq('development')
  end

  it 'defines DEFAULT_HEARTBEAT_DELAY' do
    expect(described_class::DEFAULT_HEARTBEAT_DELAY).to eq(30_000)
  end

  it 'defines DEFAULT_TIMEOUT' do
    expect(described_class::DEFAULT_TIMEOUT).to eq(10_000)
  end

  it 'defines DEFAULT_ENV' do
    expect(described_class::DEFAULT_TOKEN_ENV).to eq('POLYSEERIO_TOKEN')
  end
end
