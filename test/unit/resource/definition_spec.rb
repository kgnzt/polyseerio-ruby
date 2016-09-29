require 'resource/definition'

RSpec.describe ResourceDefinition do
  it 'correctly defines STATICS' do
    expect(ResourceDefinition::STATICS).to equal(:statics)
  end

  it 'correctly defines METHODS' do
    expect(ResourceDefinition::METHODS).to equal(:methods)
  end

  it 'correctly defines CREATABLE_STATICS' do
    expect(ResourceDefinition::CREATABLE_STATICS).to contain_exactly(
      :create
    )
  end

  it 'correctly defines READABLE_STATICS' do
    expect(ResourceDefinition::READABLE_STATICS).to contain_exactly(
      :find,
      :find_by_id
    )
  end

  it 'correctly defines DELETABLE_STATICS' do
    expect(ResourceDefinition::DELETABLE_STATICS).to contain_exactly(
      :remove
    )
  end

  it 'correctly defines UPDATABLE_STATICS' do
    expect(ResourceDefinition::UPDATABLE_STATICS).to contain_exactly(
      :update
    )
  end

  it 'correctly defines CRUD_STATICS' do
    expect(ResourceDefinition::CRUD_STATICS).to contain_exactly(
      :create,
      :find,
      :find_by_id,
      :remove,
      :update
    )
  end

  it 'correctly defines SAVABLE_INSTANCE' do
    expect(ResourceDefinition::SAVABLE_INSTANCE).to contain_exactly(
      :save
    )
  end

  it 'correctly defines RESOURCE_INSTANCE' do
    expect(ResourceDefinition::RESOURCE_INSTANCE).to contain_exactly(
      :to_json
    )
  end

  describe 'ResourceDefinition' do
    DEFINITION = ResourceDefinition::DEFINITION

    it 'defines alerts' do
      expect(DEFINITION).to have_key('alerts')
    end

    it 'defines channels' do
      expect(DEFINITION).to have_key('channels')
    end

    it 'defines environments' do
      expect(DEFINITION).to have_key('environments')
    end

    it 'defines events' do
      expect(DEFINITION).to have_key('events')
    end

    it 'defines expectations' do
      expect(DEFINITION).to have_key('expectations')
    end

    it 'defines instances' do
      expect(DEFINITION).to have_key('instances')
    end

    it 'defines logic-blocks' do
      expect(DEFINITION).to have_key('logic-blocks')
    end

    it 'defines members' do
      expect(DEFINITION).to have_key('members')
    end

    it 'defines messages' do
      expect(DEFINITION).to have_key('messages')
    end

    it 'defines settings' do
      expect(DEFINITION).to have_key('settings')
    end

    it 'defines tasks' do
      expect(DEFINITION).to have_key('tasks')
    end

    describe 'alerts' do
      alerts = DEFINITION['alerts']

      it 'has the correct statics' do
        statics = alerts[:statics]

        expect(statics).to contain_exactly(
          :create,
          :find,
          :find_by_id,
          :find_by_name,
          :update,
          :remove,
          :trigger
        )
      end
    end

    describe 'channels' do
      channels = DEFINITION['channels']

      it 'has the correct statics' do
        statics = channels[:statics]

        expect(statics).to contain_exactly(
          :create,
          :find,
          :find_by_id,
          :find_by_name,
          :update,
          :remove,
          :message
        )
      end
    end

    describe 'environments' do
      environments = DEFINITION['environments']

      it 'has the correct statics' do
        statics = environments[:statics]

        expect(statics).to contain_exactly(
          :create,
          :find,
          :find_by_id,
          :find_by_name,
          :update,
          :remove,
          :message
        )
      end
    end

    describe 'events' do
      events = DEFINITION['events']

      it 'has the correct statics' do
        statics = events[:statics]

        expect(statics).to contain_exactly(
          :create,
          :find,
          :find_by_id
        )
      end
    end

    describe 'expecations' do
      expecations = DEFINITION['expectations']

      it 'has the correct statics' do
        statics = expecations[:statics]

        expect(statics).to contain_exactly(
          :create,
          :find,
          :find_by_id,
          :find_by_name,
          :update,
          :remove,
          :check
        )
      end
    end
  end
end
