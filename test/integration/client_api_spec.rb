require 'polyseerio'

RSpec.describe Polyseerio do
  it 'raises when no token can be found' do
    expect { Polyseerio.make(token_env: 'ZOOZOO') }.to raise_error(
      ArgumentError,
      /Could not find an access token./
    )
  end

  it 'exports a start method' do
  end

  it 'can construct a client' do
    expect { Polyseerio.make(token: 'alpha') }.not_to raise_error
  end

  describe 'ExportedConstants' do
  end
end
