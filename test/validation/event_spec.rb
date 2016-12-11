require 'polyseerio'

RSpec.describe Polyseerio do
  let(:client) { Polyseerio.make }
  let(:event) { client.Event }

  it 'can create an event' do
    result = event.create(name: 'alpha').execute.value

    expect(result).not_to be_nil
  end

  it 'can find events' do
    # arity API bug when all optional
    result = event.find({}).execute.value

    expect(result).not_to be_nil
  end

  it 'can find an event by id' do
  end

  it 'can save an event instance' do
    result = event.create(name: 'alpha').execute.value

    expect(result).not_to be_nil
  end
end
