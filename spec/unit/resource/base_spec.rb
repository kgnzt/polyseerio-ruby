require 'resource/base'

RSpec.describe Polyseerio::Resource::Base do
  let(:eid) { 'testing' }
  let(:id) { 13 }
  let(:attributes) do
    {
      id: id,
      eid: eid,
      foo: 'bar',
      ping: 'pong',
      dork: 'duck'
    }
  end
  let(:instance) { described_class.new attributes }

  it 'can access passed attributes' do
    result = instance.foo

    expect(result).to eq 'bar'
  end

  it 'set passed attributes' do
    instance.foo = 'bongo'

    expect(instance.foo).to eq 'bongo'
  end

  describe 'properties' do
    it 'returns attributes' do
      result = instance.properties

      expect(result).to eq(attributes)
    end
  end

  describe 'type' do
    it '' do
    end
  end

  describe 'copts' do
    it '' do
    end
  end

  describe 'request' do
    it '' do
    end
  end

  describe 'eid' do
    it 'returns the eid' do
      result = instance.eid

      expect(result).to be eid
    end

    it 'can set the eid' do
      instance.eid = 'alpha-beta'

      expect(instance.eid).to eq 'alpha-beta'
    end
  end

  describe 'new?' do
    it 'returns false when id present' do
      instance = described_class.new(id: 100)

      result = instance.new?

      expect(result).to be false
    end
  end
end
