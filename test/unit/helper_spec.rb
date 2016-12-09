require 'helper'

RSpec.describe Helper do
  describe 'attach_to_instance' do
    let(:instance) { double('instace') }
    let(:key) { 'Foo' }
    let(:value) { 'bar' }

    it 'will attach property to instance passed' do
      Helper.attach_to_instance!(instance, [key, value])

      expect(instance.Foo).to eq('bar')
    end

    it 'will curry' do
      attach = Helper.attach_to_instance!(instance)

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

      result = Helper.defaults options

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

      result = Helper.defaults(options, defaults)

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

      result = Helper.defaults(options, defaults_one, defaults_two)

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

      result = Helper.resolve_token options

      expect(result).to eq('my-token')
    end

    it 'returns nil if token key is nil and it cant be pulled from env' do
      options = { token: nil, token_env: 'ZOOZOO' }

      result = Helper.resolve_token options

      expect(result).to eq(nil)
    end

    it 'returns token_env if in ENV' do
      token_env = 'AHAH'
      token = 'secret-token'

      ENV.store(token_env, token)

      options = { token: nil, token_env: token_env }

      result = Helper.resolve_token options

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

      result = Helper.format_payload payload

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

      result = Helper.format_payload payload

      payload[:foo] = 'wow'

      expect(result[:data][:attributes][:foo]).to eq('bar')
    end
  end
end
