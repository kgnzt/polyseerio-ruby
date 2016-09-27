require_relative '../../lib/url_builder.rb'

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

  describe 'is_routable_resource' do
    it 'returns true for routable resource' do
      result = UrlBuilder::is_routable_resource('alerts');

      expect(result).to be true
    end

    it 'returns false for non-routable resource' do
      result = UrlBuilder::is_routable_resource('environments');

      expect(result).to be false
    end
  end
end
