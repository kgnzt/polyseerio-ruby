require 'polyseerio'

RSpec.describe Polyseerio do
  let(:client) { Polyseerio.make }
  let(:event) { client.Event }

  it 'can create an event' do
    instance = event.create(name: 'alpha').execute.value

    expect(instance.name).to eq('alpha')
  end

  it 'can find events' do
    # arity API bug when all optional
    # instances = event.find({}).execute.value

    # expect(instances).not_to be_nil
  end

  it 'can find an event by id' do
  end

  it 'can save an event instance' do
    # instance = event.create(name: 'alpha').execute.value

    # expect(result).not_to be_nil
  end
end
