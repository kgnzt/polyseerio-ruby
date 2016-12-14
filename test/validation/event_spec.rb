require 'polyseerio'
require_relative 'helpers'

RSpec.describe Polyseerio do
  let(:client) { Helpers::Validation.client }
  let(:event) { client.Event }

  before(:each) { Helpers::Validation.setup client }
  after(:each) { Helpers::Validation.teardown client }

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
    instance = event.create(name: 'alpha').execute.value

    found_instance = event.find_by_id(instance.id).execute.value

    expect(found_instance.name).to eq('alpha')
  end
end
