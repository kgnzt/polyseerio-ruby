require 'polyseerio'
require_relative 'helpers'

RSpec.describe Polyseerio do
  let(:client) { Helpers::Validation.client }
  let(:resource) { client.Instance }

  before(:each) { Helpers::Validation.setup client }
  after(:each) { Helpers::Validation.teardown client }

  let(:attributes) do
    {
      name: Helpers::Validation.unique_name
    }
  end

  it 'can create an instance' do
    instance = resource.create(attributes).execute.value

    expect(instance.name).to eq(attributes[:name])
  end

  it 'can find an instance by id' do
    instance = resource.create(attributes).execute.value

    found = resource.find_by_id(instance.id).execute.value

    expect(found.name).to eq(attributes[:name])
    expect(found.id).to eq(instance.id)
  end

  it 'can update an retreived instance' do
    created = resource.create(attributes).execute.value
    instance = resource.find_by_id(created.id).execute.value

    new_name = Helpers::Validation.unique_name
    instance.name = new_name

    instance.save.execute.value

    found = resource.find_by_id(created.id).execute.value

    expect(found.name).to eq(new_name)
    expect(found.id).to eq(instance.id)
  end
end
