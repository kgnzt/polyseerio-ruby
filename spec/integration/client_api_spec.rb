require 'polyseerio'

RSpec.describe Polyseerio do
  let(:token) { 'alpha-beta-gamma' }
  let(:client) { Polyseerio.make(token: token) }

  describe described_class::Enum do
    it 'contains Color' do
      expect { described_class.const_get('Color') }.not_to raise_error
    end

    it 'contains Icon' do
      expect { described_class.const_get('Icon') }.not_to raise_error
    end

    it 'contains Strategy' do
      expect { described_class.const_get('Strategy') }.not_to raise_error
    end

    it 'contains Direction' do
      expect { described_class.const_get('Direction') }.not_to raise_error
    end

    it 'contains Determiner' do
      expect { described_class.const_get('Determiner') }.not_to raise_error
    end

    it 'contains Subtype' do
      expect { described_class.const_get('Subtype') }.not_to raise_error
    end
  end

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

  describe 'client.Alert' do
    let(:resource) { client.Alert }
    let(:instance) { resource.new {} }

    it 'has the correct static API' do
      expect(resource).to respond_to(:create)
      expect(resource).to respond_to(:find)
      expect(resource).to respond_to(:find_by_id)
      expect(resource).to respond_to(:new)
      expect(resource).to respond_to(:remove)
      expect(resource).to respond_to(:trigger)
      expect(resource).to respond_to(:update)
    end

    it 'has the correct instance API' do
      expect(instance).to respond_to(:save)
      expect(instance).to respond_to(:remove)
      expect(instance).to respond_to(:trigger)
    end
  end

  describe 'client.Channel' do
    let(:resource) { client.Channel }
    let(:instance) { resource.new {} }

    it 'has the correct static API' do
      expect(resource).to respond_to(:create)
      expect(resource).to respond_to(:find)
      expect(resource).to respond_to(:find_by_id)
      expect(resource).to respond_to(:message)
      expect(resource).to respond_to(:new)
      expect(resource).to respond_to(:remove)
      expect(resource).to respond_to(:update)
    end

    it 'has the correct instance API' do
      expect(instance).to respond_to(:save)
      expect(instance).to respond_to(:remove)
      expect(instance).to respond_to(:message)
    end
  end

  describe 'client.Environment' do
    let(:resource) { client.Environment }
    let(:instance) { resource.new {} }

    it 'has the correct static API' do
      expect(resource).to respond_to(:create)
      expect(resource).to respond_to(:find)
      expect(resource).to respond_to(:find_by_id)
      expect(resource).to respond_to(:message)
      expect(resource).to respond_to(:new)
      expect(resource).to respond_to(:remove)
      expect(resource).to respond_to(:update)
    end

    it 'has the correct instance API' do
      expect(instance).to respond_to(:save)
      expect(instance).to respond_to(:remove)
      expect(instance).to respond_to(:message)
    end
  end

  describe 'client.Event' do
    let(:resource) { client.Event }
    let(:instance) { resource.new {} }

    it 'has the correct static API' do
      expect(resource).to respond_to(:create)
      expect(resource).to respond_to(:find)
      expect(resource).to respond_to(:find_by_id)
      expect(resource).to respond_to(:new)
    end

    it 'has the correct instance API' do
      expect(instance).to respond_to(:save)
    end
  end

  describe 'client.Expectation' do
    let(:resource) { client.Expectation }
    let(:instance) { resource.new {} }

    it 'has the correct static API' do
      expect(resource).to respond_to(:check)
      expect(resource).to respond_to(:create)
      expect(resource).to respond_to(:find)
      expect(resource).to respond_to(:find_by_id)
      expect(resource).to respond_to(:new)
      expect(resource).to respond_to(:remove)
      expect(resource).to respond_to(:update)
    end

    it 'has the correct instance API' do
      expect(instance).to respond_to(:save)
      expect(instance).to respond_to(:remove)
      expect(instance).to respond_to(:check)
    end
  end

  describe 'client.Instance' do
    let(:resource) { client.Instance }
    let(:instance) { resource.new {} }

    it 'has the correct static API' do
      expect(resource).to respond_to(:attach)
      expect(resource).to respond_to(:create)
      expect(resource).to respond_to(:find)
      expect(resource).to respond_to(:find_by_id)
      expect(resource).to respond_to(:new)
      expect(resource).to respond_to(:remove)
      expect(resource).to respond_to(:update)
    end

    it 'has the correct instance API' do
      expect(instance).to respond_to(:save)
      expect(instance).to respond_to(:remove)
      expect(instance).to respond_to(:attach)
      expect(instance).to respond_to(:detach)
    end
  end

  describe 'client.Member' do
    let(:resource) { client.Member }
    let(:instance) { resource.new {} }

    it 'has the correct static API' do
      expect(resource).to respond_to(:create)
      expect(resource).to respond_to(:find)
      expect(resource).to respond_to(:find_by_id)
      expect(resource).to respond_to(:new)
      expect(resource).to respond_to(:remove)
      expect(resource).to respond_to(:update)
    end

    it 'has the correct instance API' do
      expect(instance).to respond_to(:save)
      expect(instance).to respond_to(:remove)
    end
  end

  describe 'client.Task' do
    let(:resource) { client.Task }
    let(:instance) { resource.new {} }

    it 'has the correct static API' do
      expect(resource).to respond_to(:create)
      expect(resource).to respond_to(:find)
      expect(resource).to respond_to(:find_by_id)
      expect(resource).to respond_to(:new)
      expect(resource).to respond_to(:remove)
      expect(resource).to respond_to(:update)
    end

    it 'has the correct instance API' do
      expect(instance).to respond_to(:save)
      expect(instance).to respond_to(:remove)
    end
  end
end
