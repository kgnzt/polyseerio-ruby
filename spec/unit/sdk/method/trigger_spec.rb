require 'sdk/method/trigger'

RSpec.describe Polyseerio::SDK::Method.trigger do
  let(:instance) { double('instance') }
  let(:request) { double('request') }
  let(:type) { 'alerts' }
  let(:eid) { 'testing' }
  let(:id) { 13 }
  let(:payload) do
    {
      ping: 'pong',
      king: 'kong'
    }
  end
  let(:result_double) { double('result') }

  before(:each) do
    allow(instance).to receive(:id).and_return id
    allow(instance).to receive(:eid).and_return eid
    allow(instance).to receive(:type).and_return type
    allow(instance).to receive(:request).and_return request
  end

  it 'makes a post request' do
    allow(request).to receive(:post)

    described_class.call(instance)

    expect(request).to have_received :post
  end

  it 'passes the resource trigger uri and payload to post' do
    allow(request).to receive(:post)

    described_class.call(instance, payload)

    expect(request).to have_received(:post).with(
      '/environments/testing/alerts/13/trigger',
      payload
    )
  end

  it 'returns the result of post' do
    allow(request).to receive(:post).and_return result_double

    result = described_class.call(instance)

    expect(result).to be result_double
  end
end
