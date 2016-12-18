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
  let(:mod_described_class) { Class.new(described_class) }

  describe 'initialize' do
    it 'sets the eid from passed attribute if included' do
      instance = described_class.new eid: 'zoozoo'

      result = instance.eid

      expect(result).to eq 'zoozoo'
    end

    it 'resolves the eid when none passed' do
      mod_described_class.define_singleton_method(:copts) do
        {
          environment: 'kangaroo'
        }
      end

      instance = mod_described_class.new

      result = instance.eid

      expect(result).to eq 'kangaroo'
    end

    it 'resolves the eid when none passed' do
      mod_described_class.define_singleton_method(:copts) do
        {}
      end

      instance = mod_described_class.new

      result = instance.eid

      expect(result).to eq 'development' # default
    end
  end

  describe 'attribute setter and getters' do
    it 'can access passed attributes' do
      result = instance.foo

      expect(result).to eq 'bar'
    end

    it 'set passed attributes' do
      instance.foo = 'bongo'

      expect(instance.foo).to eq 'bongo'
    end

    it 'returns nil for attributes that are not set' do
      result = instance.zoozoo

      expect(result).to be_nil
    end
  end

  describe 'override_properties' do
    let(:properties) do
      {
        foo: 'orange',
        dork: 'apple',
        cork: 21
      }
    end

    it 'correctly sets each attribute' do
      instance.override_properties properties

      # should not be changed
      expect(instance.id).to eq id
      expect(instance.eid).to eq eid
      expect(instance.ping).to eq 'pong'

      # should have been updated
      expect(instance.foo).to eq 'orange'
      expect(instance.dork).to eq 'apple'
      expect(instance.cork).to eq 21
    end
  end

  describe 'properties' do
    it 'returns attributes' do
      result = instance.properties

      expect(result).to eq(attributes)
    end
  end

  describe 'type' do
    it 'returns class.type' do
      mod_described_class.define_singleton_method(:type) do
        'alpha-beta'
      end

      instance = mod_described_class.new attributes

      result = instance.type

      expect(result).to eq('alpha-beta')
    end
  end

  describe 'copts' do
    it 'returns class.ctops' do
      mod_described_class.define_singleton_method(:copts) do
        'alpha-beta'
      end

      instance = mod_described_class.new attributes

      result = instance.copts

      expect(result).to eq('alpha-beta')
    end
  end

  describe 'request' do
    it 'returns class.request' do
      mod_described_class.define_singleton_method(:request) do
        'alpha-beta'
      end

      instance = mod_described_class.new attributes

      result = instance.request

      expect(result).to eq('alpha-beta')
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
      instance = described_class.new(id: 100, eid: 'zoo')

      result = instance.new?

      expect(result).to be false
    end
  end
end
