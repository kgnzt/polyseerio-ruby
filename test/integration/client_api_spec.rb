require 'polyseerio'

RSpec.describe Factory do
  it 'exports a start method' do
  end

  it 'can construct a client' do
    expect { Factory::make({ token: 'alpha' }) }.not_to raise_error
  end

  describe 'ExportedConstants' do
  end
end
