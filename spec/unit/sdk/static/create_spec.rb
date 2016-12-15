require 'sdk/static/create'

RSpec.describe Polyseerio::SDK::Static do
  let(:request) { double('request') }
  let(:resource) { 'events' }
  let(:copts) { {} }
  let(:attributes) { { foo: 'bar', alpha: 'beta' } }
  let(:options) { {} }
  let(:result_double) { double('result') }

  it 'returns the result of request.post' do
    allow(request).to receive(:post).and_return(result_double)

    result = described_class.create
                            .call(request, resource, copts, attributes, options)

    expect(result).to equal(result_double)
  end

  it 'passes the correct uri to request.post using copts' do
    copts = {
      environment: 'alpha'
    }

    allow(request).to receive(:post)

    described_class.create.call(request, resource, copts, attributes, options)

    expect(request).to have_received(:post)
      .with('/environments/alpha/events', attributes)
  end

  it 'passes the correct uri to request.post using options override' do
    copts = {
      environment: 'alpha'
    }
    options = {
      environment: 'beta'
    }

    allow(request).to receive(:post)

    described_class.create.call(request, resource, copts, attributes, options)

    expect(request).to have_received(:post)
      .with('/environments/beta/events', attributes)
  end
end
