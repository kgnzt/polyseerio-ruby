require 'resource'

RSpec.describe Resource do
  it 'defines ALERT' do
    expect(Resource::ALERT).to eq('alerts')
  end

  it 'defines CHANNEL' do
    expect(Resource::CHANNEL).to eq('channels')
  end

  it 'defines ENVIRONMENT' do
    expect(Resource::ENVIRONMENT).to eq('environments')
  end

  it 'defines EVENT' do
    expect(Resource::EVENT).to eq('events')
  end

  it 'defines EXPECTATION' do
    expect(Resource::EXPECTATION).to eq('expectations')
  end

  it 'defines INSTANCE' do
    expect(Resource::INSTANCE).to eq('instances')
  end

  it 'defines LOGIC_BLOCK' do
    expect(Resource::LOGIC_BLOCK).to eq('logic-blocks')
  end

  it 'defines MESSAGE' do
    expect(Resource::MESSAGE).to eq('messages')
  end

  it 'defines MEMBER' do
    expect(Resource::MEMBER).to eq('members')
  end

  it 'defines SETTING' do
    expect(Resource::SETTING).to eq('settings')
  end

  it 'defines TASK' do
    expect(Resource::TASK).to eq('tasks')
  end
end
