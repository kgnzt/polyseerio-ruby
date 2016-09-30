require 'url_builder'

RSpec.describe UrlBuilder do
  describe 'RoutableResources' do
    RoutableResources = UrlBuilder::RoutableResources

    it 'inludes the correct resources' do
      expect(RoutableResources).to contain_exactly(
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

      expect { UrlBuilder.get_resource_path(resource, options) }.to raise_error(
        ArgumentError,
        /for alerts without passing/
      )
    end

    it 'returns the correct path for non-routable resources' do
      resource = 'environments'
      options = {}

      result = UrlBuilder.get_resource_path(resource, options)

      expect(result).to eq('/environments')
    end

    it 'returns the correct path for non-routable resources with an id' do
      resource = 'environments'
      options = { id: 3 }

      result = UrlBuilder.get_resource_path(resource, options)

      expect(result).to eq('/environments/3')
    end

    it 'returns the correct path for routable resources' do
      resource = 'alerts'
      options = { eid: 'test' }

      result = UrlBuilder.get_resource_path(resource, options)

      expect(result).to eq('/environments/test/alerts')
    end

    it 'returns the correct path for routable resources with an id' do
      resource = 'alerts'
      options = { eid: 'test', id: 3 }

      result = UrlBuilder.get_resource_path(resource, options)

      expect(result).to eq('/environments/test/alerts/3')
    end
  end

  describe 'get_base_url' do
    it 'has the correct default value' do
      result = UrlBuilder.get_base_url

      expect(result).to eq('http://api.polyseer.io/polyseer/v1')
    end

    it 'can override base' do
      result = UrlBuilder.get_base_url('ping.pong.io')

      expect(result).to eq('http://ping.pong.io/v1')
    end

    it 'can override protocol' do
      result = UrlBuilder.get_base_url('alpha.io', 'ws://')

      expect(result).to eq('ws://alpha.io/v1')
    end

    it 'can override version' do
      result = UrlBuilder.get_base_url('alpha.io', 'ws://', 'v2')

      expect(result).to eq('ws://alpha.io/v2')
    end
  end

  describe 'routable_resource?' do
    it 'returns true for routable resource' do
      result = UrlBuilder.routable_resource?('alerts')

      expect(result).to be true
    end

    it 'returns false for non-routable resource' do
      result = UrlBuilder.routable_resource?('environments')

      expect(result).to be false
    end
  end
end
