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

    it 'returns correct eid when longer path used' do
      path = '/v1/environments/development/instances/10000/gauges'

      result = ResourceHelper.get_eid_from_resource_path path

      expect(result).to eq('development')
    end

    it 'returns correct eid when dash is used' do
      path = '/polyseer/v1/environments/validation-testing/events'

      result = ResourceHelper.get_eid_from_resource_path path

      expect(result).to eq('validation-testing')
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

  describe 'resource?' do
    it 'true if hash' do
      data = {}

      result = ResourceHelper.resource? data

      expect(result).to be true
    end

    it 'false if not a hash' do
      data = 'hello'

      result = ResourceHelper.resource? data

      expect(result).to be false
    end
  end

  describe 'resource_response?' do
    it 'true if response has data and data is an array' do
      response = { data: [] }

      result = ResourceHelper.resource_response? response

      expect(result).to be true
    end

    it 'true if response has data and data is a hash' do
      response = { data: {} }

      result = ResourceHelper.resource_response? response

      expect(result).to be true
    end

    it 'false if no data in response' do
      response = { foo: {} }

      result = ResourceHelper.resource_response? response

      expect(result).to be false
    end

    it 'false if data in not an array or hash' do
      response = { data: 'bar' }

      result = ResourceHelper.resource_response? response

      expect(result).to be false
    end
  end

  describe 'parse_response' do
    it 'returns the response if the response is not a resource response' do
      response = { data: 'zoo' }
      cid = 0

      result = ResourceHelper.parse_response(response, cid)

      expect(result).to equal(response)
    end
  end
end
