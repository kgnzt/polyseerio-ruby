require 'middleware'

RSpec.describe Middleware do
  let(:route) { '/foo/bar' }
  let(:payload) { { foo: 'bar' } }
  let(:options) { { ding: 'bat' } }

  describe 'pre_request' do
    it 'when a route and payload present it correctly formats payload' do
      result = Middleware.pre_request.call(route, payload)

      expect(result[0]).to eq(route)
      expect(result[1]).to eq('{"data":{"attributes":{"foo":"bar"}}}')

      expect(result.size).to eq(2)
    end

    it 'when just a route it simply returns that route' do
      result = Middleware.pre_request.call(route)

      expect(result[0]).to eq(route)

      expect(result.size).to eq(1)
    end
  end

  describe 'post_request' do
    it 'simply returns the response for now' do
      response = double('response')

      result = Middleware.post_request.call(response)

      expect(result).to equal(response)
    end
  end

  describe 'reject_request' do
  end
end
