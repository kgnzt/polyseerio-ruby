require 'sdk/factory'

RSpec.describe Polyseerio::SDK do
  describe described_class::Static do
    describe 'factory' do
      let(:request) { double('request') }
      let(:resource) { ['Wonderful'] }
      let(:statics) { [:foo, :bar] }
      let(:options) { { ping: 'pong' } }

      it 'does something' do
        # result = described_class.factory(request, resource, statics, options)
      end
    end
  end

  describe described_class::Method do
    describe 'factory' do
      let(:request) { double('request') }
      let(:resource) { ['Wonderful'] }
      let(:statics) { [:foo, :bar] }
      let(:options) { { ping: 'pong' } }

      it 'does something' do
        # result = described_class.factory(request, resource, statics, options)
      end
    end
  end
end
