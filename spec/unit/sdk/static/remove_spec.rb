require 'sdk/static/create'

RSpec.describe Polyseerio::SDK::Static do
  let(:request) { double('request') }
  let(:resource) { 'events' }
  let(:copts) { {} }
  let(:id) { 25 }
  let(:options) { {} }
  let(:result_double) { double('result') }

  it 'returns the result of request.delete' do
    allow(request).to receive(:delete).and_return(result_double)

    result = described_class.remove
                            .call(request, resource, copts, id, options)

    expect(result).to equal(result_double)
  end

  it 'passes the correct uri to request.delete using copts' do
    copts = {
      environment: 'alpha'
    }

    allow(request).to receive(:delete)

    described_class.remove.call(request, resource, copts, id, options)

    expect(request).to have_received(:delete)
      .with('/environments/alpha/events/25')
  end

  it 'passes the correct uri to request.delete using options override' do
    copts = {
      environment: 'alpha'
    }
    options = {
      environment: 'beta'
    }

    allow(request).to receive(:delete)

    described_class.remove.call(request, resource, copts, id, options)

    expect(request).to have_received(:delete)
      .with('/environments/beta/events/25')
  end
end
