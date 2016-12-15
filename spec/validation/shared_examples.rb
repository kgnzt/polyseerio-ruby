RSpec.shared_examples 'creatable' do
  it 'can create an instance' do
    instance = described_class.create(attributes).execute.value

    expect(instance.name).to eq(attributes[:name])
  end
end

RSpec.shared_examples 'findable' do
  it 'can find an instance by its primary id' do
    instance = described_class.create(attributes).execute.value

    found = described_class.find_by_id(instance.id).execute.value

    expect(found.name).to eq(attributes[:name])
    expect(found.id).to eq(instance.id)
  end
end

RSpec.shared_examples 'deletable' do
  it 'can delete an instance by its primary id' do
    instance = described_class.create(attributes).execute.value

    described_class.remove(instance.id).execute.value

    found = described_class.find_by_id(instance.id).execute.value

    expect(found).to be_nil
  end
end

RSpec.shared_examples 'updatable' do
  it 'can update an instance' do
    created = described_class.create(attributes).execute.value
    instance = described_class.find_by_id(created.id).execute.value

    new_name = Helpers::Validation.unique_name
    instance.name = new_name

    instance.save.execute.value

    found = described_class.find_by_id(created.id).execute.value

    expect(found.name).to eq(new_name)
    expect(found.id).to eq(instance.id)
  end
end
