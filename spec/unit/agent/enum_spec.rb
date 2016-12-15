require 'agent/enum'

RSpec.describe Polyseerio::Agent::Enum do
  describe described_class::Expectation do
    it 'defines IS_ALIVE' do
      expect(described_class::IS_ALIVE).to eq('is_alive')
    end
  end

  describe described_class::Event do
    it 'defines START' do
      expect(described_class::START).to eq('start')
    end
  end

  describe described_class::Signal do
    it 'defines SIGHUP' do
      expect(described_class::SIGHUP).to eq('HUP')
    end

    it 'defines SIGINT' do
      expect(described_class::SIGINT).to eq('INT')
    end

    it 'defines SIGTERM' do
      expect(described_class::SIGTERM).to eq('TERM')
    end
  end

  describe described_class::ProcessEvent do
    it 'defines EXIT' do
      expect(described_class::EXIT).to eq('exit')
    end
  end

  describe described_class::Metric do
    it 'defines MEMORY' do
      expect(described_class::MEMORY).to eq('memory')
    end
  end
end
