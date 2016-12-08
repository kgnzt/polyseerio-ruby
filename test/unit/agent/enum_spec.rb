require 'agent/enum'

RSpec.describe Enum do
  describe Enum::Expectation do
    Expectation = Enum::Expectation

    it 'defines IS_ALIVE' do
      expect(Expectation::IS_ALIVE).to eq('is_alive')
    end
  end

  describe Enum::Event do
    Event = Enum::Event

    it 'defines START' do
      expect(Event::START).to eq('start')
    end
  end

  describe Enum::Signal do
    Sig = Enum::Signal

    it 'defines SIGHUP' do
      expect(Sig::SIGHUP).to eq('HUP')
    end

    it 'defines SIGINT' do
      expect(Sig::SIGINT).to eq('INT')
    end

    it 'defines SIGTERM' do
      expect(Sig::SIGTERM).to eq('TERM')
    end
  end

  describe Enum::ProcessEvent do
    ProcessEvent = Enum::ProcessEvent

    it 'defines EXIT' do
      expect(ProcessEvent::EXIT).to eq('exit')
    end
  end

  describe Enum::Metric do
    Metric = Enum::Metric

    it 'defines MEMORY' do
      expect(Metric::MEMORY).to eq('memory')
    end
  end
end
