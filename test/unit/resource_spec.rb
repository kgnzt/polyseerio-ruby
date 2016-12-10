require 'resource'

RSpec.describe Polyseerio::Resource do
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
