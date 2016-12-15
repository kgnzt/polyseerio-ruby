require 'helper'

RSpec.describe Polyseerio::Helper do
  describe 'add_to_proc_map' do
    let(:mod) do
      Class.new do
        def self.foo
          proc { 'a' }
        end
      end
    end
    let(:item) { [:foo, '_'] }
    let(:acc) { {} }

    it 'correctly adds' do
      result = described_class.add_to_proc_map(mod, item, acc)

      expect(result).to have_key(:foo)
      expect(result.fetch(:foo)).to be_kind_of(Proc)
    end

    it 'wont add if module does not contain method' do
      result = described_class.add_to_proc_map(mod, [:bar, '_'], acc)

      expect(result).not_to have_key(:bar)
    end

    it 'is curried' do
      accumulator = described_class.add_to_proc_map(mod)

      result = accumulator.call(item, acc)

      expect(result).to have_key(:foo)
      expect(result.fetch(:foo)).to be_kind_of(Proc)
    end
  end

  describe 'resource_to_type' do
    let(:resource) { 'foos' }

    it 'returns the correct string type' do
      result = described_class.resource_to_type resource

      expect(result).to eq('foo')
    end

    it 'handles - types' do
      resource = 'logic-blocks'

      result = described_class.resource_to_type resource

      expect(result).to eq('logic-block')
    end
  end

  describe 'memoize_function' do
    let(:func) { double('func') }
    let(:get_key) { proc { |param| param.to_sym } }
    let(:result_double) { 'foo' }

    it 'returns the result of func when called' do
      allow(func).to receive(:call).and_return(result_double)

      memoized = described_class.memoize_function(func, get_key)

      result = memoized.call('a')

      expect(result).to eq(result_double)
    end

    it 'returns the result of func when called again' do
      allow(func).to receive(:call).and_return(result_double)

      memoized = described_class.memoize_function(func, get_key)

      result_one = memoized.call('a')
      result_two = memoized.call('a')

      expect(result_one).to eq(result_double)
      expect(result_two).to eq(result_double)
    end

    it 'will only call func once per cached get_key' do
      allow(func).to receive(:call).and_return(result_double)

      memoized = described_class.memoize_function(func, get_key)

      expect(func).to receive(:call).once

      memoized.call('a')
      memoized.call('a')
      memoized.call('a')
    end

    it 'will correctly handle more complex cache keys' do
      get_key = proc { |_, b, __, d| :"#{b}-#{d}" }

      allow(func).to receive(:call).and_return(result_double)

      memoized = described_class.memoize_function(func, get_key)

      expect(func).to receive(:call).exactly(3).times

      memoized.call('a', 'b', 'c', 'd')
      memoized.call('y', 'b', 'c', 'z') # arg b and d the same should memoize
      memoized.call('a', 'z', 'c', 'd') # arg b differs
      memoized.call('a', 'b', 'c', 'z') # arg d differs
      memoized.call('a', 'b', 'c', 'd') # arg b and d the same should memoize
    end
  end

  describe 'identity' do
    it 'returns what was passed' do
      result = described_class.identity('alpha')

      expect(result).to eq('alpha')
    end
  end

  describe 'rekey' do
    it 'converts hash keys based on map' do
      hash = {
        dog: 'bar'
      }
      map = {
        dog: :foo
      }

      result = described_class.rekey(hash, map)

      expect(result).to eq(foo: 'bar')
    end
  end

  describe 'attach_to_instance' do
    let(:instance) { double('instace') }
    let(:key) { 'Foo' }
    let(:value) { 'bar' }

    it 'will attach property to instance passed' do
      described_class.attach_to_instance!(instance, [key, value])

      expect(instance.Foo).to eq('bar')
    end

    it 'will curry' do
      attach = described_class.attach_to_instance!(instance)

      attach.call([key, value])

      expect(instance.Foo).to eq('bar')
    end
  end

  describe 'defaults' do
    it 'correctly returns options if no defaults provided' do
      options = {
        alpha: 'beta',
        gamma: 'delta'
      }

      result = described_class.defaults options

      expect(result).to eq(
        alpha: 'beta',
        gamma: 'delta'
      )
    end

    it 'merges defaults when provided' do
      options = {
        alpha: 'beta',
        gamma: 'delta'
      }
      defaults = {
        zoo: 'animals',
        gamma: 'zeta'
      }

      result = described_class.defaults(options, defaults)

      expect(result).to eq(
        alpha: 'beta',
        gamma: 'delta',
        zoo: 'animals'
      )
    end

    it 'can merge multiple defaults' do
      options = {
        alpha: 'beta',
        ding: 'dong'
      }
      defaults_one = {
        alpha: 'zeta',
        dork: 'duck'
      }
      defaults_two = {
        alpha: 'theta',
        dork: 'lala',
        ping: 'pong',
        ding: 'wow'
      }

      result = described_class.defaults(options, defaults_one, defaults_two)

      expect(result).to eq(
        ding: 'dong',
        alpha: 'beta',
        dork: 'duck',
        ping: 'pong'
      )
    end
  end

  describe 'resolve_token' do
    it 'returns token if token key is not nil' do
      options = { token: 'my-token' }

      result = described_class.resolve_token options

      expect(result).to eq('my-token')
    end

    it 'returns nil if token key is nil and it cant be pulled from env' do
      options = { token: nil, token_env: 'ZOOZOO' }

      result = described_class.resolve_token options

      expect(result).to eq(nil)
    end

    it 'returns token_env if in ENV' do
      token_env = 'AHAH'
      token = 'secret-token'

      ENV.store(token_env, token)

      options = { token: nil, token_env: token_env }

      result = described_class.resolve_token options

      expect(result).to eq(token)

      ENV.delete token_env
    end
  end

  describe 'format_payload' do
    it 'correctly formats a data payload' do
      payload = {
        foo: 'bar',
        alpha: {
          beta: 'something'
        }
      }

      result = described_class.format_payload payload

      expect(result).to eq(
        data: {
          attributes: {
            foo: 'bar',
            alpha: {
              beta: 'something'
            }
          }
        }
      )
    end

    it 'copies the payload hash' do
      payload = { foo: 'bar' }

      result = described_class.format_payload payload

      payload[:foo] = 'wow'

      expect(result[:data][:attributes][:foo]).to eq('bar')
    end
  end
end
