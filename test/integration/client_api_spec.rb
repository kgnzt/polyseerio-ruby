require 'polyseerio'

RSpec.describe Polyseerio do
  let(:token) { 'alpha-beta-gamma' }
  let(:client) { Polyseerio.make(token: token) }

  it 'contains Alert' do
    expect(client).to respond_to(:Alert)
  end

  it 'contains Channel' do
    expect(client).to respond_to(:Channel)
  end

  it 'contains Environment' do
    expect(client).to respond_to(:Environment)
  end

  it 'contains Event' do
    expect(client).to respond_to(:Event)
  end

  it 'contains Expectation' do
    expect(client).to respond_to(:Expectation)
  end

  it 'contains Instance' do
    expect(client).to respond_to(:Instance)
  end

  it 'contains LogicBlock' do
    expect(client).to respond_to(:LogicBlock)
  end

  it 'contains Member' do
    expect(client).to respond_to(:Member)
  end

  it 'contains Message' do
    expect(client).to respond_to(:Member)
  end

  it 'contains Task' do
    expect(client).to respond_to(:Task)
  end
end
