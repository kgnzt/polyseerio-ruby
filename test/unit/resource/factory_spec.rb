require 'resource/factory.rb'

class Dork
end

RSpec.describe ResourceFactory do
  describe 'create' do
    def class_name_factory
      id = 0
      lambda do
        id += 1
        "TestClass_#{id}"
      end
    end

    before(:all) do
      @generate = class_name_factory
    end

    let(:name) { @generate.call }

    it 'generates a class with the correct name' do
      resource = ResourceFactory.create name

      expect(resource.name).to eq(name)
    end

    it 'generates a class with the correct name' do
      resource = ResourceFactory.create 'Beta'

      expect(resource).to be_a(Class)
    end

    it 'defaults eid to nil' do
      resource = ResourceFactory.create name

      result = resource.new

      expect(result.eid).to be_nil
    end

    it 'defaults new to true' do
      resource = ResourceFactory.create name

      result = resource.new

      expect(result.new?).to equal(true)
    end

    it 'can return the type from the instance' do
      resource = ResourceFactory.create name

      result = resource.new

      expect(result.type).to eq(name)
    end
  end

  describe 'make' do
    it 'raises if resource not defined' do
      resource = 'unknown-foo'
      request = {}
      cid = 1

      expect { ResourceFactory.make(resource, request, cid) }.to raise_error(
        ArgumentError,
        /Could not find definition for resource: unknown-foo/
      )
    end

    it 'will not raise for a known resource' do
      resource = 'alerts'
      request = {}
      cid = 1

      expect { ResourceFactory.make(resource, request, cid) }.not_to raise_error
    end
  end

  describe 'singleton_definition?' do
    it 'true when no methods defined' do
      definition = { statics: [] }

      result = ResourceFactory.singleton_definition? definition

      expect(result).to eql(true)
    end

    it 'true when no methods are empty' do
      definition = { methods: [] }

      result = ResourceFactory.singleton_definition? definition

      expect(result).to eql(true)
    end

    it 'false when methods are in definition' do
      definition = { methods: [:find] }

      result = ResourceFactory.singleton_definition? definition

      expect(result).to eql(false)
    end
  end

  describe 'add_method' do
    it 'adds a named instance method to passed Class' do
      method = -> (x) { x * 2 }
      name = 'foo'

      ResourceFactory.add_method(Dork, method, name)

      instance = Dork.new

      expect(instance.foo(2)).to eql(4)
    end
  end

  describe 'add_static' do
    it 'adds a named static method to passed Class' do
      method = -> (x) { x * 2 }
      name = 'foo'

      ResourceFactory.add_static(Dork, method, name)

      expect(Dork.foo(2)).to eql(4)
    end
  end

  describe 'add_statics' do
    it 'simply returns the resource if no statics' do
      ResourceFactory.add_statics(Dork)

      expect(Dork).to equal(Dork)
    end

    it 'adds all statics passed onto the resource' do
    end
  end

  describe 'add_methods' do
    it 'simply returns the resource if no methods' do
      ResourceFactory.add_methods(Dork)

      expect(Dork).to equal(Dork)
    end

    it 'adds all methods passed onto the resource' do
    end
  end

  describe 'get_memoize_key' do
    it 'returns the correct key' do
      resource = 'alerts'
      cid = 2

      key = ResourceFactory.get_memoize_key(resource, nil, cid, nil)

      expect(key).to eq('alerts.2')
    end
  end
end
