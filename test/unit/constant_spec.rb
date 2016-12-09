require 'constant'

RSpec.describe Constant do
  it 'defines ACCESS_TOKEN_HEADER' do
    expect(Constant::ACCESS_TOKEN_HEADER).to eq('X-AUTH-HEADER')
  end

  it 'defines DEFAULT_API_BASE_URL' do
    expect(Constant::DEFAULT_API_BASE_URL).to eq('api.polyseer.io/polyseer')
  end

  it 'defines DEFAULT_API_PROTOCOL' do
    expect(Constant::DEFAULT_API_PROTOCOL).to eq('https://')
  end

  it 'defines DEFAULT_API_VERSION' do
    expect(Constant::DEFAULT_API_VERSION).to eq('v1')
  end

  it 'defines DEFAULT_ENV' do
    expect(Constant::DEFAULT_ENV).to eq('RAILS_ENV')
  end

  it 'defines DEFAULT_ENVIRONMENT' do
    expect(Constant::DEFAULT_ENVIRONMENT).to eq('production')
  end

  it 'defines DEFAULT_TIMEOUT' do
    expect(Constant::DEFAULT_TIMEOUT).to eq(10_000)
  end

  it 'defines DEFAULT_ENV' do
    expect(Constant::DEFAULT_TOKEN_ENV).to eq('POLYSEERIO_TOKEN')
  end
end
