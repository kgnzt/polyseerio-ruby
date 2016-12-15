require 'agent/handler/interface'

RSpec.describe HandlerInterface do
  it 'defines SETUP' do
    expect(HandlerInterface::SETUP).to eq(:setup)
  end

  it 'defines TEARDOWN' do
    expect(HandlerInterface::TEARDOWN).to eq(:teardown)
  end
end
