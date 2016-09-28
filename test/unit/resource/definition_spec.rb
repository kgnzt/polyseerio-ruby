require 'resource/definition'

RSpec.describe ResourceDefinition do
  it 'correctly defines STATICS' do
    expect(ResourceDefinition::STATICS).to equal(:statics)
  end

  it 'correctly defines METHODS' do
    expect(ResourceDefinition::METHODS).to equal(:methods)
  end

  it 'correctly defines CREATABLE_STATICS' do
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
  end
end
