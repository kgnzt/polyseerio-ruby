require 'sdk/helper'

RSpec.describe Polyseerio::SDK::Helper do
  describe 'remove_non_resolving_values' do
    let(:hash) do
      {
        foo: 'beta',
        size: 22,
        king: proc { |kong| kong }
      }
    end

    it 'removes all non resolable hash values' do
      result = described_class.remove_non_resolving_values hash

      expect(result.size).to eq(1)
      expect(result).to have_key(:king)

      expect(result).not_to have_key(:foo)
      expect(result).not_to have_key(:size)
    end
  end

  describe 'instance_to_uri' do
    let(:instance) { double('instance') }
    let(:id) { 13 }
    let(:eid) { 'testing' }
    let(:type) { 'events' }

    before(:each) do
      allow(instance).to receive(:id).and_return id
      allow(instance).to receive(:eid).and_return eid
      allow(instance).to receive(:type).and_return type
    end

    it 'is a shorthand for building instance uri' do
      result = described_class.instance_to_uri instance

      expect(result).to eq('/environments/testing/events/13')
    end
  end

  describe 'accumulate_procs' do
    let(:type) { 'foo' }
    let(:map) do
      {
        alpha: 'beta',
        ping: 'pong',
        dork: 'duck'
      }
    end
    let(:name) { :alpha }
    let(:acc) do
      {
        large: 'furnace'
      }
    end

    it 'raises when map does not contain name' do
      args = [type, map, 'alpha', acc]

      expect { described_class.accumulate_procs(*args) }.to raise_error(
        RuntimeError,
        /SDK factory could not find a foo alpha./
      )
    end

    it 'correctly accumulates onto hash' do
      result = described_class.accumulate_procs(type, map, name, acc)

      expect(result).to eq(alpha: 'beta', large: 'furnace')
    end

    it 'is curried' do
      accumulator = described_class.accumulate_procs(type, map)

      result = accumulator.call(name, acc)

      expect(result).to eq(alpha: 'beta', large: 'furnace')
    end
  end

  describe 'reduce_options' do
    it 'simply returns options if no copts or defaults' do
      options = { foo: 'bar' }

      result = described_class.reduce_options options

      expect(result).to eq(
        foo: 'bar'
      )
    end

    it 'passed arguments trump copts' do
      options = { foo: 'bar', alpha: 'beta' }
      copts = { foo: 'zing', dork: 'duck' }

      result = described_class.reduce_options(options, copts)

      expect(result).to eq(
        foo: 'bar',
        alpha: 'beta',
        dork: 'duck'
      )
    end

    it 'passed arguments trump copts and copts trump defaults ' do
      options = { foo: 'bar', alpha: 'beta' }
      copts = { foo: 'zing', dork: 'duck', pop: 'bam' }
      defaults = { foo: 'wow', dork: 'cork', pork: 'chop' }

      result = described_class.reduce_options(options, copts, defaults)

      expect(result).to eq(
        foo: 'bar',
        alpha: 'beta',
        pop: 'bam',
        dork: 'duck',
        pork: 'chop'
      )
    end
  end

  describe 'resolve_eid' do
    it 'returns the environment if in options hash' do
      options = { environment: 'alpha' }

      result = described_class.resolve_eid options

      expect(result).to eq('alpha')
    end

    it 'returns development if nothing can be deduced' do
      options = { deduce: false }

      result = described_class.resolve_eid options

      expect(result).to eq('development')
    end

    it 'if deduce is true the env will be used' do
      env = 'ZOOZOO'
      environment = 'foo-bar'

      ENV.store(env, environment)

      options = { deduce: true, env: env }

      result = described_class.resolve_eid options

      expect(result).to eq(environment)

      ENV.delete env
    end

    it 'if deduce is true but there is no env it will return development' do
      env = 'ZOOZOO'

      options = { deduce: true, env: env }

      result = described_class.resolve_eid options

      expect(result).to eq('development')
    end
  end
end
