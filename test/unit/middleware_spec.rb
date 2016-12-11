require 'middleware'

RSpec.describe Polyseerio::Middleware do
  let(:route) { '/foo/bar' }
  let(:payload) { { foo: 'bar' } }
  let(:options) { { ding: 'bat' } }

  describe described_class::Pre do
    describe 'format_arguments' do
      it 'when a route and payload present it correctly formats payload' do
        result = described_class.format_arguments.call(route, payload)

        expect(result[0]).to eq(route)
        expect(result[1]).to eq('{"data":{"attributes":{"foo":"bar"}}}')

        expect(result.size).to eq(2)
      end

      it 'when just a route it simply returns that route' do
        result = described_class.format_arguments.call(route)

        expect(result[0]).to eq(route)

        expect(result.size).to eq(1)
      end
    end
  end

  describe described_class::Post do
    describe 'to_response' do
      it 'takes rest response and convert it to Polyseerio::Response' do
        response = double('response')

        result = described_class.to_response.call(response)

        expect(result).to be_instance_of(Polyseerio::Response)
      end
    end

    describe 'parse_response' do
    end
  end

  describe described_class::Reject do
  end
end
