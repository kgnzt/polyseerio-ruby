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
