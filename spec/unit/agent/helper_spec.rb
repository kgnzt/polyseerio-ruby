require 'agent/helper'
require 'concurrent'

RSpec.describe Polyseerio::Agent::Helper do
  describe 'should_handle' do
    it 'returns true if the passed value is true' do
      result = described_class.should_handle true

      expect(result).to eq(true)
    end

    it 'returns value of enabled if hash with key' do
      result = described_class.should_handle(enabled: true)

      expect(result).to eq(true)
    end

    it 'returns false if passed hash does not have enabled' do
      result = described_class.should_handle(foo: true)

      expect(result).to eq(false)
    end

    it 'returns false if something other than hash or bool passed' do
      result = described_class.should_handle 'ding-dong'

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
    it 'will use the setup key when present in handler' do
      handler = {
        foo: {
          alpha: {
            setup: proc { || Concurrent::Promise.fulfill('lime') }
          }
        }
      }
      type = :foo
      config = {
        alpha: {
          car: 'dog'
        }
      }

      promise = described_class.setup_with_handler(handler, type, config)

      result = promise.execute.value

      expect(result).to eq(%w(lime))
    end

    it 'correctly calls each handler using config and type' do
      handler = {
        foo: {
          alpha: proc { || Concurrent::Promise.fulfill('ping') },
          gamma: proc { || Concurrent::Promise.fulfill('pong') }
        }
      }
      type = :foo
      config = {
        alpha: {
          car: 'dog'
        },
        gamma: {
          tiger: 'lion'
        }
      }

      promise = described_class.setup_with_handler(handler, type, config)

      result = promise.execute.value

      expect(result).to eq(%w(ping pong))
    end
  end

  describe 'teardown_with_handler' do
    it 'will use the teardown key when present in handler' do
      handler = {
        foo: {
          alpha: {
            teardown: proc { || Concurrent::Promise.fulfill('lime') }
          }
        }
      }
      type = :foo
      config = {
        alpha: {
          car: 'dog'
        }
      }

      promise = described_class.teardown_with_handler(handler, type, config)

      result = promise.execute.value

      expect(result).to eq(%w(lime))
    end

    it 'correctly calls each handler using config and type' do
      handler = {
        foo: {
          alpha: proc { || Concurrent::Promise.fulfill('ping') },
          gamma: proc { || Concurrent::Promise.fulfill('pong') }
        }
      }
      type = :foo
      config = {
        alpha: {
          car: 'dog'
        },
        gamma: {
          tiger: 'lion'
        }
      }

      promise = described_class.setup_with_handler(handler, type, config)

      result = promise.execute.value

      expect(result).to eq(%w(ping pong))
    end
  end
end
