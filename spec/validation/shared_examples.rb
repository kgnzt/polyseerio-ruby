# Ensure a resource can be created.
RSpec.shared_examples 'creatable' do
  it 'can create an instance using Resource.create' do
    create_instance = described_class.create(attributes)
    instance = create_instance.execute.value

    expect(create_instance).to be_fulfilled
    expect(instance.name).to eq(attributes[:name])
  end

  it 'can create an instance from Resource.new then instance.save' do
    # TODO: fill out
  end
end

# Ensure a resource can be found.
RSpec.shared_examples 'findable' do
  it 'can find an instance by its primary id, Resource.find_by_id' do
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
  it 'can delete an instance using its primary id, Resource.remove' do
    create_instance = described_class.create(attributes)
    instance = create_instance.execute.value

    expect(create_instance).to be_fulfilled

    remove_instance = described_class.remove(instance.id)
    remove_instance.execute.value

    expect(remove_instance).to be_fulfilled

    find_instance = described_class.find_by_id(instance.id)
    found = find_instance.execute.value

    expect(find_instance).to be_rejected
    expect(found).to be_nil
  end

  it 'can delete an instance using instance.remove' do
    create_instance = described_class.create(attributes)
    instance = create_instance.execute.value

    expect(create_instance).to be_fulfilled

    remove = instance.remove()

    expect(remove).to be_fulfilled

    find_instance = described_class.find_by_id(instance.id)
    found = find_instance.execute.value

    expect(find_instance).to be_rejected
    expect(found).to be_nil
  end
end

# Ensure a resource can be updates.
RSpec.shared_examples 'updatable' do
  it 'can update an instance using its primary id, Resource.update' do
    # create an instance
    create_instance = described_class.create(attributes)
    instance = create_instance.execute.value
    expect(create_instance).to be_fulfilled

    new_name = Helpers::Validation.unique_name
    update = described_class.update(instance.id, name: new_name)

    updated_instance = update.execute.value

    # ensure it was updated
    expect(update).to be_fulfilled
    expect(updated_instance.name).to eq(new_name)

    # try reloading an asserting it was updated
    reload = described_class.find_by_id(instance.id)
    instance = reload.execute.value

    expect(reload).to be_fulfilled
    expect(instance.name).to eq(new_name)
  end

  it 'can update an instance using instance.save' do
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
    found.name = new_name

    # save it
    save_instance = found.save
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

# Ensure a resource can be triggered.
RSpec.shared_examples 'triggerable' do
  it 'can trigger an instance' do
    # create an instance
    create_instance = described_class.create(attributes)
    instance = create_instance.execute.value
    expect(create_instance).to be_fulfilled

    payload = { foo: 'bar' }

    # trigger resource
    trigger = instance.trigger(payload)
    trigger.execute.value

    # ensure it was one
    expect(trigger).to be_fulfilled
  end
end
