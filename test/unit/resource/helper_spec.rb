require 'resource/helper'

RSpec.describe ResourceHelper do
  describe 'get_eid_from_resource_path' do
    it 'returns nil if no eid present in path' do
      path = '/members/22'

      result = ResourceHelper.get_eid_from_resource_path path

      expect(result).to equal(nil)
    end

    it 'correctly returns the eid' do
      path = '/environments/alpha/alerts/33'

      result = ResourceHelper.get_eid_from_resource_path path

      expect(result).to eq('alpha')
    end
  end

  describe 'resource_collection?' do
    it 'true if an array' do
      data = ['alpha']

      result = ResourceHelper.resource_collection? data

      expect(result).to be true
    end

    it 'false if not an array' do
      data = 'hello'

      result = ResourceHelper.resource_collection? data

      expect(result).to be false
    end
  end
end
