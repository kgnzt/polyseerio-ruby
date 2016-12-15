require 'enum'

RSpec.describe Polyseerio::Enum do
  describe described_class::Resource do
    it 'defines ALERT' do
      expect(described_class::ALERT).to eq('alerts')
    end

    it 'defines CHANNEL' do
      expect(described_class::CHANNEL).to eq('channels')
    end

    it 'defines ENVIRONMENT' do
      expect(described_class::ENVIRONMENT).to eq('environments')
    end

    it 'defines EVENT' do
      expect(described_class::EVENT).to eq('events')
    end

    it 'defines EXPECTATION' do
      expect(described_class::EXPECTATION).to eq('expectations')
    end

    it 'defines INSTANCE' do
      expect(described_class::INSTANCE).to eq('instances')
    end

    it 'defines LOGIC_BLOCK' do
      expect(described_class::LOGIC_BLOCK).to eq('logic-blocks')
    end

    it 'defines MESSAGE' do
      expect(described_class::MESSAGE).to eq('messages')
    end

    it 'defines MEMBER' do
      expect(described_class::MEMBER).to eq('members')
    end

    it 'defines SETTING' do
      expect(described_class::SETTING).to eq('settings')
    end

    it 'defines TASK' do
      expect(described_class::TASK).to eq('tasks')
    end
  end

  describe described_class::Type do
    it 'defines ALERT' do
      expect(described_class::ALERT).to eq('alert')
    end

    it 'defines CHANNEL' do
      expect(described_class::CHANNEL).to eq('channel')
    end

    it 'defines ENVIRONMENT' do
      expect(described_class::ENVIRONMENT).to eq('environment')
    end

    it 'defines EVENT' do
      expect(described_class::EVENT).to eq('event')
    end

    it 'defines EXPECTATION' do
      expect(described_class::EXPECTATION).to eq('expectation')
    end

    it 'defines INSTANCE' do
      expect(described_class::INSTANCE).to eq('instance')
    end

    it 'defines LOGIC_BLOCK' do
      expect(described_class::LOGIC_BLOCK).to eq('logic-block')
    end

    it 'defines MEMBER' do
      expect(described_class::MEMBER).to eq('member')
    end

    it 'defines MESSAGE' do
      expect(described_class::MESSAGE).to eq('message')
    end

    it 'defines SETTING' do
      expect(described_class::SETTING).to eq('setting')
    end

    it 'defines TASK' do
      expect(described_class::TASK).to eq('task')
    end
  end

  describe described_class::Determiner do
    it 'defines ONE' do
      expect(described_class::ONE).to eq('one')
    end

    it 'defines SOME' do
      expect(described_class::SOME).to eq('some')
    end
  end

  describe described_class::Direction do
    it 'defines INBOUND' do
      expect(described_class::INBOUND).to eq('inbound')
    end

    it 'defines OUTBOUND' do
      expect(described_class::OUTBOUND).to eq('outbound')
    end
  end

  describe described_class::Subtype do
    it 'defines LONG_RUNNING' do
      expect(described_class::LONG_RUNNING).to eq('long_running')
    end

    it 'defines OUTBOUND' do
      expect(described_class::PERIODIC).to eq('periodic')
    end
  end

  describe described_class::Color do
    it 'defines BLUE' do
      expect(described_class::BLUE).to eq('blue')
    end

    it 'defines BROWN' do
      expect(described_class::BROWN).to eq('brown')
    end

    it 'defines GREEN' do
      expect(described_class::GREEN).to eq('green')
    end

    it 'defines ORANGE' do
      expect(described_class::ORANGE).to eq('orange')
    end

    it 'defines PURPLE' do
      expect(described_class::PURPLE).to eq('purple')
    end

    it 'defines RED' do
      expect(described_class::RED).to eq('red')
    end

    it 'defines TEAL' do
      expect(described_class::TEAL).to eq('teal')
    end

    it 'defines WHITE' do
      expect(described_class::WHITE).to eq('white')
    end

    it 'defines YELLOW' do
      expect(described_class::YELLOW).to eq('yellow')
    end

    it 'defines NONE' do
      expect(described_class::NONE).to equal(nil)
    end
  end

  describe described_class::Icon do
    it 'defines THUMBS_UP' do
      expect(described_class::THUMBS_UP).to eq('thumbs-up')
    end

    it 'defines CALENDAR' do
      expect(described_class::CALENDAR).to eq('calendar')
    end

    it 'defines SERVER' do
      expect(described_class::SERVER).to eq('server')
    end

    it 'defines SIGNAL' do
      expect(described_class::SIGNAL).to eq('wifi')
    end

    it 'defines GIT' do
      expect(described_class::GIT).to eq('git')
    end

    it 'defines CODE' do
      expect(described_class::CODE).to eq('code')
    end

    it 'defines CHECK' do
      expect(described_class::CHECK).to eq('check')
    end

    it 'defines ERROR' do
      expect(described_class::ERROR).to eq('exclamation-triangle')
    end

    it 'defines PENCIL' do
      expect(described_class::PENCIL).to eq('pencil')
    end

    it 'defines CHAIN' do
      expect(described_class::CHAIN).to eq('chain')
    end

    it 'defines CHAIN_BROKEN' do
      expect(described_class::CHAIN_BROKEN).to eq('chain-broken')
    end

    it 'defines NONE' do
      expect(described_class::NONE).to equal(nil)
    end
  end

  describe described_class::Strategy do
    it 'defines FALLBACK' do
      expect(described_class::FALLBACK).to eq(:fallback)
    end

    it 'defines ID' do
      expect(described_class::ID).to eq(:id)
    end
  end
end
