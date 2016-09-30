require 'helper'

RSpec.describe Helper do
  describe 'format_payload' do
    it 'correctly formats a data payload' do
      payload = { 
        foo: 'bar',
        alpha: {
          beta: 'something'
        }
      }

      result = Helper.format_payload payload

      expect(result).to eq({
        data: {
          attributes: {
            foo: 'bar',
            alpha: {
              beta: 'something'
            }
          }
        }
      })
    end

    it 'copies the payload hash' do
      payload = { foo: 'bar' }

      result = Helper.format_payload payload

      payload[:foo] = 'wow'

      expect(result[:data][:attributes][:foo]).to eq('bar')
    end
  end
end
