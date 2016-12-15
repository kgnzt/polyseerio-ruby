require 'polyseerio'
require_relative 'helpers'

RSpec.describe Polyseerio do
  let(:client) { Helpers::Validation.client }
  let(:resource) { client.Event }

  before(:each) { Helpers::Validation.setup client }
  after(:each) { Helpers::Validation.teardown client }

  it 'can create an event' do
    instance = resource.create(name: 'alpha').execute.value

    expect(instance.name).to eq('alpha')
  end

  it 'can find an event by id' do
    instance = resource.create(name: 'alpha').execute.value

    found = resource.find_by_id(instance.id).execute.value

    expect(found.name).to eq('alpha')
  end
end
