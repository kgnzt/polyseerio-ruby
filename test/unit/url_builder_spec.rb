require 'url_builder'

RSpec.describe Polyseerio::URL do
  describe 'RoutableResources' do
    it 'inludes the correct resources' do
      expect(described_class::RoutableResources).to contain_exactly(
        'alerts',
        'events',
        'expectations',
        'instances',
        'tasks'
      )
    end
  end

  describe 'get_resource_path' do
    it 'raises when routable resource without an eid' do
      resource = 'alerts'
      options = {}
      args = [resource, options]

      expect { described_class.get_resource_path(*args) }.to raise_error(
        ArgumentError,
        /for alerts without passing/
      )
    end

    it 'returns the correct path for non-routable resources' do
      resource = 'environments'
      options = {}

      result = described_class.get_resource_path(resource, options)

      expect(result).to eq('/environments')
    end

    it 'returns the correct path for non-routable resources with an id' do
      resource = 'environments'
      options = { id: 3 }

      result = described_class.get_resource_path(resource, options)

      expect(result).to eq('/environments/3')
    end

    it 'returns the correct path for routable resources' do
      resource = 'alerts'
      options = { eid: 'test' }

      result = described_class.get_resource_path(resource, options)

      expect(result).to eq('/environments/test/alerts')
    end

    it 'returns the correct path for routable resources with an id' do
      resource = 'alerts'
      options = { eid: 'test', id: 3 }

      result = described_class.get_resource_path(resource, options)

      expect(result).to eq('/environments/test/alerts/3')
    end
  end

  describe 'get_base_url' do
    it 'has the correct default version' do
      result = described_class.get_base_url 'api.polyseer.io', 'http://', nil

      expect(result).to eq('http://api.polyseer.io/v1')
    end

    it 'will generate the correct url' do
      result = described_class.get_base_url('api.polyseer.io', 'ws://', 'v2')

      expect(result).to eq('ws://api.polyseer.io/v2')
    end
  end

  describe 'routable_resource?' do
    it 'returns true for routable resource' do
      result = described_class.routable_resource?('alerts')

      expect(result).to be true
    end

    it 'returns false for non-routable resource' do
      result = described_class.routable_resource?('environments')

      expect(result).to be false
    end
  end
end
