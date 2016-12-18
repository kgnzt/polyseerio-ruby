require 'polyseerio'

RSpec.describe Polyseerio do
  describe Polyseerio::DEFAULT_CLIENT_OPTIONS do
    it 'includes the correct resources' do
      expect(described_class).to eq(
        agent: {},
        deduce: true,
        environment: 'development',
        env: 'RAILS_ENV',
        timeout: 10_000,
        token: nil,
        token_env: 'POLYSEERIO_TOKEN',
        upsert_env: true,
        version: 'v1'
      )
    end
  end

  describe Polyseerio::REQUIRED_RESOURCES do
    Resources = Polyseerio::REQUIRED_RESOURCES

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

  describe Polyseerio::CLIENT_RESOURCE_PATHS do
    it 'defines alerts' do
      expect(described_class['alerts']).to eq(:Alert)
    end

    it 'defines channels' do
      expect(described_class['channels']).to eq(:Channel)
    end

    it 'defines environments' do
      expect(described_class['environments']).to eq(:Environment)
    end

    it 'defines events' do
      expect(described_class['events']).to eq(:Event)
    end

    it 'defines expectations' do
      expect(described_class['expectations']).to eq(:Expectation)
    end

    it 'defines instances' do
      expect(described_class['instances']).to eq(:Instance)
    end

    it 'defines logic_blocks' do
      expect(described_class['logic-blocks']).to eq(:LogicBlock)
    end

    it 'defines members' do
      expect(described_class['members']).to eq(:Member)
    end

    it 'defines settings' do
      expect(described_class['settings']).to eq(:Settings)
    end

    it 'defines tasks' do
      expect(described_class['tasks']).to eq(:Task)
    end
  end
end
