require 'sdk/static/find_by_name'

RSpec.describe Polyseerio::SDK::Static do
  let(:request) { double('request') }
  let(:resource) { 'events' }
  let(:copts) { {} }
  let(:name) { 'foo' }
  let(:options) { {} }
  let(:result_double) { double('result') }

  it 'returns the result of request.get' do
    allow(request).to receive(:get).and_return(result_double)

    result = described_class.find_by_name
                            .call(request, resource, copts, name, options)

    expect(result).to equal(result_double)
  end

  it 'when resource is an environment correct uri is used' do
    resource = 'environments'

    allow(request).to receive(:get).and_return(result_double)

    described_class.find_by_name.call(request, resource, copts, name, options)

    expect(request).to have_received(:get)
      .with('/environments/name/foo')
  end

  it 'when environment passed in options corrent path is requested' do
    resource = 'events'
    options = { environment: 'alpha' }

    allow(request).to receive(:get).and_return(result_double)

    described_class.find_by_name.call(request, resource, copts, name, options)

    expect(request).to have_received(:get)
      .with('/environments/alpha/events/name/foo')
  end
end
