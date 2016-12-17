require 'sdk/static/update'

RSpec.describe Polyseerio::SDK::Static do
  let(:request) { double('request') }
  let(:resource) { 'alerts' }
  let(:copts) { {} }
  let(:id) { 13 }
  let(:updates) { { foo: 'bar', alpha: 'beta' } }
  let(:options) { {} }
  let(:result_double) { double('result') }

  it 'returns the result of request.put' do
    allow(request).to receive(:put).and_return(result_double)

    result = described_class.update.call(
      request,
      resource,
      copts,
      id,
      updates,
      options
    )

    expect(result).to equal(result_double)
  end

  it 'passes the correct uri to request.put using copts' do
    copts = {
      environment: 'alpha'
    }

    allow(request).to receive(:put)

    described_class.update.call(
      request,
      resource,
      copts,
      id,
      updates,
      options
    )

    expect(request).to have_received(:put)
      .with('/environments/alpha/alerts/13', updates)
  end

  it 'passes the correct uri to request.post using options override' do
    copts = {
      environment: 'alpha'
    }
    options = {
      environment: 'beta'
    }

    allow(request).to receive(:put)

    described_class.update.call(
      request,
      resource,
      copts,
      id,
      updates,
      options
    )

    expect(request).to have_received(:put)
      .with('/environments/beta/alerts/13', updates)
  end
end
