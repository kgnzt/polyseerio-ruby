require 'response'

RSpec.describe Polyseerio::Response do
  let(:rest_response) { double('resource') }
  let(:response) { described_class.new(rest_response) }

  describe 'initialize' do
    it 'throws without a passed response' do
      expect { described_class.new }.to raise_error(ArgumentError)
    end
  end

  describe 'body' do
    let(:body) { '{"foo":"bar"}' }

    it 'parses rest_response body JSON into has' do
      allow(rest_response).to receive(:body).and_return(body)

      result = response.body

      expect(result).to eq(
        foo: 'bar'
      )
    end

    it 'memoizes the result' do
      allow(rest_response).to receive(:body).and_return(body)

      response.body
      response.body

      expect(rest_response).to have_received(:body).once
    end
  end

  describe 'request' do
    let(:request) { double('request') }

    it 'returns the rest_response.request' do
      allow(rest_response).to receive(:request).and_return(request)

      result = response.request

      expect(result).to equal(request)
    end
  end
end
