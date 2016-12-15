# Ensure a resource can be created.
RSpec.shared_examples 'creatable' do
  it 'can create an instance' do
    create_instance = described_class.create(attributes)
    instance = create_instance.execute.value

    expect(create_instance).to be_fulfilled
    expect(instance.name).to eq(attributes[:name])
  end
end

# Ensure a resource can be found.
RSpec.shared_examples 'findable' do
  it 'can find an instance by its primary id' do
    create_instance = described_class.create(attributes)

    instance = create_instance.execute.value
    expect(create_instance).to be_fulfilled

    find_instance = described_class.find_by_id(instance.id)
    found = find_instance.execute.value

    expect(find_instance).to be_fulfilled

    expect(found.name).to eq(attributes[:name])
    expect(found.id).to eq(instance.id)
  end
end

# Ensure a resource can be deleted.
RSpec.shared_examples 'deletable' do
  it 'can delete an instance by its primary id' do
    create_instance = described_class.create(attributes)
    instance = create_instance.execute.value

    expect(create_instance).to be_fulfilled

    remove_instance = described_class.remove(instance.id)
    remove_instance.execute.value

    expect(remove_instance).to be_fulfilled

    find_instance = described_class.find_by_id(instance.id)
    found = find_instance.execute.value

    expect(find_instance).to be_rejected
  end
end

# Ensure a resource can be updates.
RSpec.shared_examples 'updatable' do
  it 'can update an instance' do
    # create an instance
    create_instance = described_class.create(attributes)
    instance = create_instance.execute.value
    expect(create_instance).to be_fulfilled

    # load it
    find_instance = described_class.find_by_id(instance.id)
    found = find_instance.execute.value
    expect(find_instance).to be_fulfilled

    # update the name
    new_name = Helpers::Validation.unique_name
    instance.name = new_name

    # save it
    save_instance = instance.save
    save_instance.execute.value
    expect(save_instance).to be_fulfilled

    # load it gain
    find_again = described_class.find_by_id(instance.id)
    found = find_again.execute.value
    expect(find_again).to be_fulfilled

    # ensure attributes have been updates
    expect(found.name).to eq(new_name)
    expect(found.id).to eq(instance.id)
  end
end
