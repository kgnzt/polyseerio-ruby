require 'resource/definition'

RSpec.describe Polyseerio::Resource::Definition do
  it 'correctly defines STATICS' do
    expect(described_class::STATICS).to equal(:statics)
  end

  it 'correctly defines METHODS' do
    expect(described_class::METHODS).to equal(:methods)
  end

  it 'correctly defines CREATABLE_STATICS' do
    expect(described_class::CREATABLE_STATICS).to contain_exactly(
      :create
    )
  end

  it 'correctly defines READABLE_STATICS' do
    expect(described_class::READABLE_STATICS).to contain_exactly(
      :find,
      :find_by_id
    )
  end

  it 'correctly defines DELETABLE_STATICS' do
    expect(described_class::DELETABLE_STATICS).to contain_exactly(
      :remove
    )
  end

  it 'correctly defines UPDATABLE_STATICS' do
    expect(described_class::UPDATABLE_STATICS).to contain_exactly(
      :update
    )
  end

  it 'correctly defines CRUD_STATICS' do
    expect(described_class::CRUD_STATICS).to contain_exactly(
      :create,
      :find,
      :find_by_id,
      :remove,
      :update
    )
  end

  it 'correctly defines SAVABLE_INSTANCE' do
    expect(described_class::SAVABLE_INSTANCE).to contain_exactly(
      :save
    )
  end

  it 'correctly defines RESOURCE_INSTANCE' do
    expect(described_class::RESOURCE_INSTANCE).to contain_exactly(
      :to_json
    )
  end

  describe described_class::DEFINITION do
    it 'defines alerts' do
      expect(described_class).to have_key('alerts')
    end

    it 'defines channels' do
      expect(described_class).to have_key('channels')
    end

    it 'defines environments' do
      expect(described_class).to have_key('environments')
    end

    it 'defines events' do
      expect(described_class).to have_key('events')
    end

    it 'defines expectations' do
      expect(described_class).to have_key('expectations')
    end

    it 'defines instances' do
      expect(described_class).to have_key('instances')
    end

    it 'defines logic-blocks' do
      expect(described_class).to have_key('logic-blocks')
    end

    it 'defines members' do
      expect(described_class).to have_key('members')
    end

    it 'defines messages' do
      expect(described_class).to have_key('messages')
    end

    it 'defines settings' do
      expect(described_class).to have_key('settings')
    end

    it 'defines tasks' do
      expect(described_class).to have_key('tasks')
    end

    describe 'alerts' do
      alerts = described_class['alerts']

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
      channels = described_class['channels']

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
      environments = described_class['environments']

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
      events = described_class['events']

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
      expecations = described_class['expectations']

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

    describe 'instances' do
      instances = described_class['instances']

      it 'has the correct statics' do
        statics = instances[:statics]

        expect(statics).to contain_exactly(
          :create,
          :find,
          :find_by_id,
          :find_by_name,
          :update,
          :remove,
          :attach
        )
      end
    end

    describe 'logic-blocks' do
      logic_blocks = described_class['logic-blocks']

      it 'has the correct statics' do
        statics = logic_blocks[:statics]

        expect(statics).to contain_exactly(
          :create,
          :find,
          :find_by_id,
          :update,
          :remove,
          :execute
        )
      end
    end

    describe 'members' do
      members = described_class['members']

      it 'has the correct statics' do
        statics = members[:statics]

        expect(statics).to contain_exactly(
          :create,
          :find,
          :find_by_id,
          :update,
          :remove
        )
      end
    end

    describe 'messages' do
      messages = described_class['messages']

      it 'has the correct statics' do
        statics = messages[:statics]

        expect(statics).to contain_exactly(
          :create,
          :find,
          :find_by_id,
          :update,
          :remove
        )
      end
    end

    describe 'settings' do
      settings = described_class['settings']

      it 'has the correct statics' do
        statics = settings[:statics]

        expect(statics).to be_empty
      end
    end

    describe 'tasks' do
      tasks = described_class['tasks']

      it 'has the correct statics' do
        statics = tasks[:statics]

        expect(statics).to contain_exactly(
          :create,
          :find,
          :find_by_id,
          :update,
          :remove
        )
      end
    end
  end
end
