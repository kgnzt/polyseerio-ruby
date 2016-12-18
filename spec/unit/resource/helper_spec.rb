require 'resource/helper'

RSpec.describe Polyseerio::Resource::Helper do
  describe 'forward_self' do
    let(:class_double) { Class.new }
    let(:func) { double('func') }
    let(:arg_one) { double('arg_one') }
    let(:arg_two) { double('arg_two') }
    let(:result_double) { double('result') }
    let(:method) { :foo }

    it 'returns the result of the passed func when called' do
      allow(func).to receive(:call).and_return result_double

      forwarded_func = described_class.forward_self(func)

      result = forwarded_func.call(arg_one, arg_two)

      expect(result).to equal(result_double)
    end

    it 'correctly forwards self to passed function with args' do
      allow(func).to receive(:call)
      method = described_class.forward_self(func)

      class_double.class_eval do
        define_method(:foo, &method)
      end

      instance = class_double.new

      instance.foo(arg_one, arg_two)

      expect(func).to have_received(:call).with(instance, arg_one, arg_two)
    end
  end

  describe 'get_eid_from_resource_path' do
    it 'returns nil if no eid present in path' do
      path = '/members/22'

      result = described_class.get_eid_from_resource_path path

      expect(result).to equal(nil)
    end

    it 'correctly returns the eid' do
      path = '/environments/alpha/alerts/33'

      result = described_class.get_eid_from_resource_path path

      expect(result).to eq('alpha')
    end

    it 'returns correct eid when longer path used' do
      path = '/v1/environments/development/instances/10000/gauges'

      result = described_class.get_eid_from_resource_path path

      expect(result).to eq('development')
    end

    it 'returns correct eid when dash is used' do
      path = '/polyseer/v1/environments/validation-testing/events'

      result = described_class.get_eid_from_resource_path path

      expect(result).to eq('validation-testing')
    end
  end

  describe 'resource_collection?' do
    it 'true if an array' do
      data = ['alpha']

      result = described_class.resource_collection? data

      expect(result).to be true
    end

    it 'false if not an array' do
      data = 'hello'

      result = described_class.resource_collection? data

      expect(result).to be false
    end
  end

  describe 'resource?' do
    it 'true if hash' do
      data = {}

      result = described_class.resource? data

      expect(result).to be true
    end

    it 'false if not a hash' do
      data = 'hello'

      result = described_class.resource? data

      expect(result).to be false
    end
  end

  describe 'resource_response?' do
    it 'true if response has data and data is an array' do
      response = { data: [] }

      result = described_class.resource_response? response

      expect(result).to be true
    end

    it 'true if response has data and data is a hash' do
      response = { data: {} }

      result = described_class.resource_response? response

      expect(result).to be true
    end

    it 'false if no data in response' do
      response = { foo: {} }

      result = described_class.resource_response? response

      expect(result).to be false
    end

    it 'false if data in not an array or hash' do
      response = { data: 'bar' }

      result = described_class.resource_response? response

      expect(result).to be false
    end
  end

  describe 'parse_response' do
    let(:response) { double('response') }

    it 'returns the response if the response is not a resource response' do
      allow(response).to receive(:body).and_return(data: 'zoo')
      cid = 0

      result = described_class.parse_response(response, cid)

      expect(result).to equal(response)
    end
  end
end
