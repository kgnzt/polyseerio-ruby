require 'resource/routine'
require 'concurrent'

RSpec.describe Polyseerio::Resource::Routine do
  describe 'upsert' do
    let(:resource) { double('resource') }
    let(:attributes) do
      {
        name: 'foo'
      }
    end
    let(:result_double) { double('result') }
    let(:error_double) { StandardError.new double('error') }

    it 'when find_by_name is fulfilled it resolves result' do
      allow(resource).to receive(:find_by_name).and_return(
        Concurrent::Promise.fulfill(result_double)
      )

      upsert = described_class.upsert(resource, attributes)

      upsert.execute.value

      expect(upsert).to be_fulfilled_with result_double
    end

    it 'when find_by_name rejects 404 it creates with attributes' do
      allow(resource).to receive(:find_by_name).and_return(
        Concurrent::Promise.reject(error_double)
      )
      allow(error_double).to receive(:http_code).and_return 404
      allow(resource).to receive(:create).and_return(
        Concurrent::Promise.fulfill(result_double)
      )

      upsert = described_class.upsert(resource, attributes)

      upsert.execute.value

      expect(upsert).to be_fulfilled_with result_double
    end

    it 'when find_by_name rejects non 404 it rejects' do
      allow(resource).to receive(:find_by_name).and_return(
        Concurrent::Promise.reject(error_double)
      )
      allow(error_double).to receive(:http_code).and_return 500

      upsert = described_class.upsert(resource, attributes)

      upsert.execute.value

      expect(upsert).to be_rejected_with error_double
    end

    it 'raises when attributes do not contain name' do
      attributes = { foo: 'bar' }

      expect { described_class.upsert(resource, attributes) }.to raise_error(
        ArgumentError,
        /Passed attributes must contain a name./
      )
    end
  end
end
