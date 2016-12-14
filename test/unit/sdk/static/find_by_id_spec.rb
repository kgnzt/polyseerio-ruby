require 'sdk/static/find_by_id'

RSpec.describe Polyseerio::SDK::Static do
  let(:request) { double('request') }
  let(:resource) { 'events' }
  let(:copts) { {} }
  let(:id) { 13 }
  let(:options) { {} }
  let(:result_double) { double('result') }

  it 'returns the result of request.get' do
    allow(request).to receive(:get).and_return(result_double)

    result = described_class.find_by_id
                            .call(request, resource, copts, id, options)

    expect(result).to equal(result_double)
  end

  it 'passes the correct uri to request.get using copts' do
    copts = {
      environment: 'alpha'
    }

    allow(request).to receive(:get).and_return(result_double)

    described_class.find_by_id.call(request, resource, copts, id, options)

    expect(request).to have_received(:get)
      .with('/environments/alpha/events/13')
  end

  it 'passes the correct uri to request.get using options override' do
    copts = {
      environment: 'alpha'
    }
    options = {
      environment: 'beta'
    }

    allow(request).to receive(:get).and_return(result_double)

    described_class.find_by_id.call(request, resource, copts, id, options)

    expect(request).to have_received(:get)
      .with('/environments/beta/events/13')
  end
end
