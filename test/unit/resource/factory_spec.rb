require 'resource/factory.rb'

RSpec.describe Polyseerio::Resource::Factory do
  let(:resource_double) { Class.new }

  describe 'to_class_name' do
    it 'takes a resource symbol and returns a class name' do
      result = described_class.to_class_name :events

      expect(result).to eq('Event')
    end

    it 'correctly handles names with - in them' do
      result = described_class.to_class_name 'logic-blocks'

      expect(result).to eq('LogicBlock')
    end

    it 'correctly handles names with - in them with cid' do
      result = described_class.to_class_name('logic-blocks', 7)

      expect(result).to eq('LogicBlock7')
    end

    it 'can take an optional cid to postfix' do
      result = described_class.to_class_name(:events, 7)

      expect(result).to eq('Event7')
    end
  end

  describe 'create' do
    def class_name_factory
      id = 0
      lambda do
        id += 1
        "test#{id}"
      end
    end

    before(:all) do
      @generate = class_name_factory
    end

    let(:name) { @generate.call }
    let(:attributes) do
      {
        foo: 'bar',
        ding: 'dong',
        two: 2,
        yes: true
      }
    end

    it 'generates a class with the correct name' do
      resource = described_class.create name

      expect(resource.name).to eq('Test1')
    end

    it 'generates a class with the correct name' do
      resource = described_class.create 'Beta'

      expect(resource).to be_a(Class)
    end

    it 'defaults eid to nil' do
      resource = described_class.create name

      result = resource.new

      expect(result.eid).to be_nil
    end

    it 'defaults new to true' do
      resource = described_class.create name

      result = resource.new

      expect(result.new?).to equal(true)
    end

    it 'correctly has a resource method' do
      resource = described_class.create name

      instance = resource.new

      result = instance.resource

      expect(result).to eq(name)
    end

    it 'will use attributes for method missing' do
      resource = described_class.create name

      instance = resource.new attributes

      expect(instance.foo).to eq('bar')
      expect(instance.ding).to eq('dong')
      expect(instance.two).to eq(2)
      expect(instance.yes).to eq(true)
    end
  end

  describe 'make' do
    it 'raises if resource not defined' do
      resource = 'unknown-foo'
      request = {}
      cid = 1

      expect { described_class.make(resource, request, cid) }.to raise_error(
        ArgumentError,
        /Could not find definition for resource: unknown-foo/
      )
    end
  end

  describe 'defines_singleton?' do
    it 'true when no methods defined' do
      definition = { statics: [] }

      result = described_class.defines_singleton? definition

      expect(result).to eql(true)
    end

    it 'true when no methods are empty' do
      definition = { methods: [] }

      result = described_class.defines_singleton? definition

      expect(result).to eql(true)
    end

    it 'false when methods are in definition' do
      definition = { methods: [:find] }

      result = described_class.defines_singleton? definition

      expect(result).to eql(false)
    end
  end

  describe 'add_method' do
    it 'adds a named instance method to passed Class' do
      method = proc { |x| x * 2 }
      name = 'foo'

      described_class.add_method([name, method], resource_double)

      instance = resource_double.new

      expect(instance.foo(2)).to eql(4)
    end
  end

  describe 'add_static' do
    it 'adds a named static method to passed Class' do
      method = proc { |x| x * 2 }
      name = 'foo'

      described_class.add_static([name, method], resource_double)

      expect(resource_double.foo(2)).to eql(4)
    end
  end

  describe 'add_statics' do
    it 'simply returns the resource if no statics' do
      described_class.add_statics(resource_double)

      expect(resource_double).to equal(resource_double)
    end

    it 'adds all statics passed onto the resource' do
    end
  end

  describe 'add_methods' do
    it 'simply returns the resource if no methods' do
      described_class.add_methods(resource_double, {})

      expect(resource_double).to equal(resource_double)
    end

    it 'adds all methods passed onto the resource' do
    end
  end

  describe 'get_memoize_key' do
    it 'returns the correct key' do
      resource = 'alerts'
      cid = 2

      key = described_class.get_memoize_key(resource, nil, cid, nil)

      expect(key).to eq('alerts.2')
    end
  end
end
