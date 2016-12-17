require 'agent/enum'

RSpec.describe Polyseerio::Agent::Enum do
  describe described_class::Expectation do
    it 'defines IS_ALIVE' do
      expect(described_class::IS_ALIVE).to eq(:is_alive)
    end
  end

  describe described_class::Event do
    it 'defines START' do
      expect(described_class::START).to eq(:start)
    end

    it 'defines STOP' do
      expect(described_class::STOP).to eq(:stop)
    end
  end

  describe described_class::Fact do
    it 'defines PID' do
      expect(described_class::PID).to eq(:pid)
    end

    it 'defines GID' do
      expect(described_class::GID).to eq(:gid)
    end
  end

  describe described_class::Signal do
    it 'defines SIGHUP' do
      expect(described_class::SIGHUP).to eq(:HUP)
    end

    it 'defines SIGINT' do
      expect(described_class::SIGINT).to eq(:INT)
    end

    it 'defines SIGTERM' do
      expect(described_class::SIGTERM).to eq(:TERM)
    end
  end

  describe described_class::Process do
    it 'defines EXIT' do
      expect(described_class::EXIT).to eq(:exit)
    end
  end

  describe described_class::Metric do
    it 'defines MEMORY' do
      expect(described_class::MEMORY).to eq(:memory)
    end

    it 'defines CPU' do
      expect(described_class::CPU).to eq(:cpu)
    end

    it 'defines UPTIME' do
      expect(described_class::UPTIME).to eq(:uptime)
    end
  end
end
