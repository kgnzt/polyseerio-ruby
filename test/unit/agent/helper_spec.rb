require 'agent/helper'
require 'concurrent'

RSpec.describe Helper do
  describe 'should_handle' do
    it 'returns true if the passed value is true' do
      result = Helper::should_handle true

      expect(result).to eq(true)
    end

    it 'returns value of enabled if hash with key' do
      result = Helper::should_handle({ enabled: true })

      expect(result).to eq(true)
    end

    it 'returns false if passed hash does not have enabled' do
      result = Helper::should_handle({ foo: true })

      expect(result).to eq(false)
    end

    it 'returns false if something other than hash or bool passed' do
      result = Helper::should_handle 'ding-dong'

      expect(result).to eq(false)
    end
  end

  describe 'generate_name' do
    it 'simply returns ruby-instance for now' do
      result = Helper::generate_name

      expect(result).to eq('ruby-instance')
    end
  end

  describe 'resolve_name' do
    it 'if there is a non nil name in config it is returned' do
      result = Helper::resolve_name({ name: 'king-kong' })

      expect(result).to eq('king-kong')
    end

    it 'generates a name if name is nil' do
      result = Helper::resolve_name({ name: nil })

      expect(result).to be_kind_of(String)
      expect(result.length).to be > 0
    end
  end

  describe 'setup_with_handler' do
    it 'correctly calls each handler using config and type' do
      handler = {
        foo: {
          alpha: Proc.new {|a| 
            Concurrent::Promise.fulfill('ping') # turn this into a mock
          },
          gamma: Proc.new {|a| 
            Concurrent::Promise.fulfill('pong') # turn this into a mock
          }
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
      arg_one = 'ding'
      arg_two = 'dong'

      promise = Helper::setup_with_handler(handler, type, config, arg_one, arg_two)

      result = promise.execute.value

      expect(result).to eq(['ping', 'pong'])
    end
  end
end
