require 'polyseerio'

RSpec.describe ClientResourcePaths do
  describe Factory do
    it 'includes the correct resources' do
      token = 'dork.duck'

      result = Factory.make(token)

      expect(result).to be nil
    end

    it 'raises without a token' do
      expect { Factory.make() }.to raise_error(ArgumentError)
    end
  end

  describe Defaults do
    describe Defaults::COPTS do
      COPTS = Defaults::COPTS

      it 'includes the correct resources' do
        expect(COPTS).to eq(
          env: 'RAILS_ENV',
          version: 'v1',
          deduce: true
        )
      end
    end
  end

  describe RequiredResources do
    Resources = RequiredResources::RESOURCES

    it 'includes the correct resources' do
      expect(Resources).to contain_exactly(
        'alerts',
        'channels',
        'environments',
        'events',
        'expectations',
        'instances',
        'logic-blocks',
        'members',
        'settings',
        'tasks'
      )
    end
  end

  describe ClientResourcePaths do
    PATHS = ClientResourcePaths::PATHS

    it 'defines alerts' do
      expect(PATHS['alerts']).to eq(:Alert)
    end

    it 'defines channels' do
      expect(PATHS['channels']).to eq(:Channel)
    end

    it 'defines environments' do
      expect(PATHS['environments']).to eq(:Environment)
    end

    it 'defines events' do
      expect(PATHS['events']).to eq(:Event)
    end

    it 'defines expectations' do
      expect(PATHS['expectations']).to eq(:Expectation)
    end

    it 'defines instances' do
      expect(PATHS['instances']).to eq(:Instance)
    end

    it 'defines logic_blocks' do
      expect(PATHS['logic-blocks']).to eq(:LogicBlock)
    end

    it 'defines members' do
      expect(PATHS['members']).to eq(:Member)
    end

    it 'defines settings' do
      expect(PATHS['settings']).to eq(:Settings)
    end

    it 'defines tasks' do
      expect(PATHS['tasks']).to eq(:Task)
    end
  end
end
