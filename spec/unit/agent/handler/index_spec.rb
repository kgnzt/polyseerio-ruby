require 'agent/handler/index'

RSpec.describe Polyseerio::Agent::Handler do
  describe 'extract_handler_options' do
    let(:options) do
      {
        foo: 'bar',
        ding: 'dong',
        metric: 'alpha',
        event: 'beta'
      }
    end

    it 'correctly extracts handler keys' do
      result = described_class.extract_options options

      expect(result).to eq metric: 'alpha', event: 'beta'
    end
  end
end
