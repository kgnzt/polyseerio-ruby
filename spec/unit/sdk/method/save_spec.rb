require 'sdk/method/save'

RSpec.describe Polyseerio::SDK::Method.save do
  let(:instance) { double('instance') }
  let(:request) { double('request') }
  let(:type) { 'alerts' }
  let(:eid) { 'testing' }
  let(:id) { 13 }
  let(:properties) do
    {
      ping: 'pong',
      king: 'kong'
    }
  end
  let(:result_double) { double('result') }
  let(:response) { double('response') }

  before(:each) do
    allow(instance).to receive(:id).and_return id
    allow(instance).to receive(:eid).and_return eid
    allow(instance).to receive(:type).and_return type
    allow(instance).to receive(:properties).and_return properties
    allow(instance).to receive(:request).and_return request

    allow(instance).to receive(:override_properties)

    allow(response).to receive(:properties)
  end

  describe 'saving new instances' do
    it 'makes a post request when new' do
      allow(instance).to receive(:new?).and_return true
      allow(request).to receive(:post).and_return(
        Concurrent::Promise.fulfill(response)
      )

      described_class.call(instance).execute.value

      expect(request).to have_received :post
    end

    it 'passes the correct uri and properties to post' do
      allow(instance).to receive(:new?).and_return true
      allow(request).to receive(:post).and_return(
        Concurrent::Promise.fulfill(response)
      )

      described_class.call(instance).execute.value

      expect(request).to have_received(:post).with(
        '/environments/testing/alerts/13',
        properties
      )
    end

    it 'returns itself when saved' do
      allow(instance).to receive(:new?).and_return true
      allow(request).to receive(:post).and_return(
        Concurrent::Promise.fulfill(response)
      )

      result = described_class.call(instance).execute.value

      expect(result).to be instance
    end
  end

  describe 'saving existing instances' do
    it 'makes a put request when not new' do
      allow(instance).to receive(:new?).and_return false
      allow(request).to receive(:put)

      described_class.call(instance)

      expect(request).to have_received :put
    end

    it 'passes the correct uri and properties to put' do
      allow(instance).to receive(:id).and_return nil
      allow(instance).to receive(:new?).and_return false
      allow(request).to receive(:put)

      described_class.call(instance)

      expect(request).to have_received(:put).with(
        '/environments/testing/alerts',
        properties
      )
    end

    it 'returns the result of put' do
      allow(instance).to receive(:new?).and_return false
      allow(request).to receive(:put).and_return result_double

      result = described_class.call(instance)

      expect(result).to be result_double
    end
  end
end
