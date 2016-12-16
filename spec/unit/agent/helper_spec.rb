require 'agent/helper'
require 'matchers'
require 'concurrent'

RSpec.describe Polyseerio::Agent::Helper do
  describe 'create_subtype_iterator' do
    let(:handlers) do
      {
        alpha: {
          ping: 'pong',
          dork: 'duck'
        }
      }
    end
    let(:iteratee) { double('iteratee') }
    let(:arg_one) { 'foo' }
    let(:arg_two) { 'bar' }
    let(:result_double) { 'bar' }

    it 'returns the result of the iteratee' do
      allow(iteratee).to receive(:call).and_return(result_double)

      iterator = described_class.create_subtype_iterator(
        handlers,
        iteratee,
        arg_one,
        arg_two
      )

      result = iterator.call(:alpha, handlers[:alpha])

      expect(result).to eq(result_double)
    end

    it 'rejects if the handler subtype is not in the handler\'s options' do
      iterator = described_class.create_subtype_iterator(
        handlers,
        iteratee,
        arg_one,
        arg_two
      )

      promise = iterator.call(:zoo, handlers[:alpha]) # :zoo not in handlers
      promise.execute

      expect(promise).to be_rejected_with(
        'Could not find a handler subtype: zoo.'
      )
    end

    it 'correctly forwards arguments to the iteratee call' do
      allow(iteratee).to receive(:call).and_return(result_double)

      iterator = described_class.create_subtype_iterator(
        handlers,
        iteratee,
        arg_one,
        arg_two
      )

      iterator.call(:alpha, handlers[:alpha])

      expect(iteratee).to have_received(:call).with(
        handlers,
        :alpha,
        handlers[:alpha],
        arg_one,
        arg_two
      )
    end
  end

  describe 'create_handler' do
    let(:iteratee) { double('iteratee') }
    let(:map) do
      {
        foo: {
          ping: 'pong',
          alpha: 'beta'
        },
        bar: {
          dork: 'duck'
        }
      }
    end
    let(:client) { double('client') }
    let(:config) do
      {
        foo: {
          ping: true,
          alpha: true
        },
        bar: {
          dork: true
        }
      }
    end
    let(:type) { :foo }
    let(:arg_one) { 'lunch' }
    let(:arg_two) { 'dinner' }

    it 'resolves to the result of all handler promises as an array' do
      handler = described_class.create_handler(iteratee)

      allow(iteratee).to receive(:call).and_return(
        proc { |a| Concurrent::Promise.new { a } }
      )

      promise = handler.call(map, client, config, type, arg_one, arg_two)

      result = promise.execute.value

      expect(promise).to be_fulfilled
      expect(result).to eq([[:ping, true], [:alpha, true]])
    end

    it 'rejects if the handler type is not in the handlers' do
      handler = described_class.create_handler(iteratee)

      promise = handler.call(map, client, config, :zoo, arg_one, arg_two)

      promise.execute.value

      expect(promise).to be_rejected_with 'Could not find a handler type: zoo.'
    end

    it 'correctly forwards arguments to the iteratee call' do
    end
  end

  describe 'reduce_handler_option' do
    let(:config) { true }
    let(:name) { :foo }
    let(:acc) { {} }

    it 'adds to accumular if should handle config' do
      result = described_class.reduce_handler_option.call([name, config], acc)

      expect(result).to eq(foo: true)
    end

    it 'wont add to accumular if should not handle config' do
      result = described_class.reduce_handler_option.call([name, false], acc)

      expect(result).to eq({})
    end
  end

  describe 'filter_enabled_handler_options' do
    let(:options) do
      {
        foo: true,
        bar: false,
        ding: {
          enabled: false
        },
        dong: {
          enabled: true,
          alpha: 'beta'
        }
      }
    end

    it 'correctly reduces the options to those that are enabled' do
      result = described_class.filter_enabled_handler_options options

      expect(result).to eq(
        foo: true,
        dong: {
          enabled: true,
          alpha: 'beta'
        }
      )
    end
  end

  describe 'filter_handlers' do
    let(:options) do
      {
        foo: {
          ding: true,
          dong: {
            enabled: false
          }
        },
        bar: {
          alpha: false,
          beta: true,
          fish: {
            enabled: true,
            kind: 'salmon'
          }
        }
      }
    end

    it 'correctly reduces the options to those that are enabled' do
      result = described_class.filter_handlers options

      expect(result).to eq(
        foo: {
          ding: true
        },
        bar: {
          beta: true,
          fish: {
            enabled: true,
            kind: 'salmon'
          }
        }
      )
    end
  end

  describe 'handle?' do
    it 'returns true if the passed value is true' do
      result = described_class.handle? true

      expect(result).to eq(true)
    end

    it 'returns value of enabled if hash with key' do
      result = described_class.handle?(enabled: true)

      expect(result).to eq(true)
    end

    it 'returns false if passed hash does not have enabled' do
      result = described_class.handle?(foo: true)

      expect(result).to eq(false)
    end

    it 'returns false if something other than hash or bool passed' do
      result = described_class.handle? 'ding-dong'

      expect(result).to eq(false)
    end
  end

  describe 'generate_name' do
    it 'simply returns ruby-instance for now' do
      result = described_class.generate_name

      expect(result).to eq('ruby-instance')
    end
  end

  describe 'resolve_name' do
    it 'if there is a non nil name in config it is returned' do
      result = described_class.resolve_name(name: 'king-kong')

      expect(result).to eq('king-kong')
    end

    it 'generates a name if name is nil' do
      result = described_class.resolve_name(name: nil)

      expect(result).to be_kind_of(String)
      expect(result.length).to be > 0
    end
  end

  describe 'setup_with_handler' do
    let(:map) do
      {
        foo: {
          alpha: proc { || Concurrent::Promise.fulfill('lime') },
          beta: proc { || Concurrent::Promise.fulfill('lemon') }
        }
      }
    end
    let(:client) { double('client') }
    let(:config) do
      {
        foo: {
          alpha: {
            ping: 'pong'
          },
          beta: {
            dork: 'duck'
          }
        }
      }
    end
    let(:arg_one) { 'wow' }
    let(:arg_two) { 'pow' }

    it 'iterates over each config item and uses the map to resolve them' do
      setup = described_class.setup_with_handler(map, client, config)

      perform = setup.call(:foo)

      perform.execute.value

      expect(perform).to be_fulfilled_with(%w(lime lemon))
    end

    it 'will use a setup key when present in handler map' do
      map = {
        foo: {
          alpha: {
            setup: proc { || Concurrent::Promise.fulfill('lime') }
          }
        }
      }
      config = {
        foo: {
          alpha: true
        }
      }

      setup = described_class.setup_with_handler(map, client, config)

      perform = setup.call(:foo)

      perform.execute.value

      expect(perform).to be_fulfilled_with(%w(lime))
    end

    it 'will reject if type is not in handler map' do
      setup = described_class.setup_with_handler(map, client, config)

      perform = setup.call(:zoozoo) # not in map

      perform.execute.value

      expect(perform).to be_rejected_with(
        'Could not find a handler type: zoozoo.'
      )
    end

    it 'will resolve if type in map but there is no config for it' do
      config = {
        zoozoo: {
          ding: 'dong'
        }
      }
      setup = described_class.setup_with_handler(map, client, config)

      perform = setup.call(:foo) # in map, but not in config

      perform.execute.value

      expect(perform).to be_fulfilled_with([])
    end
  end

  describe 'teardown_with_handler' do
    let(:map) do
      {
        foo: {
          alpha: {
            teardown: proc { || Concurrent::Promise.fulfill('lime') }
          },
          beta: {
            teardown: proc { || Concurrent::Promise.fulfill('lemon') }
          }
        }
      }
    end
    let(:client) { double('client') }
    let(:config) do
      {
        foo: {
          alpha: {
            ping: 'pong'
          },
          beta: {
            dork: 'duck'
          }
        }
      }
    end
    let(:arg_one) { 'wow' }
    let(:arg_two) { 'pow' }

    it 'will use the teardown key when present in handler' do
      teardown = described_class.teardown_with_handler(map, client, config)

      perform = teardown.call(:foo)

      perform.execute.value

      expect(perform).to be_fulfilled_with(%w(lime lemon))
    end
  end
end
