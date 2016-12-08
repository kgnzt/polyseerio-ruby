require 'helper'

RSpec.describe Helper do
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
