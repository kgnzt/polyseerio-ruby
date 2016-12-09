require 'middleware'

RSpec.describe Middleware do
  describe 'pre_request' do
    it 'simply returns identical options when no body' do
      options = {
        foo: 'bar'
      }

      result = Middleware.pre_request.call(options)

      expect(result).to eq(foo: 'bar')
    end

    it 'formats the body when present' do
      options = {
        body: {
          ping: 'pong',
          alpha: 'beta',
          meta: {
            world: 'peace'
          }
        }
      }

      result = Middleware.pre_request.call(options)

      expect(result).to eq(
        body: {
          data: {
            attributes: {
              ping: 'pong',
              alpha: 'beta',
              meta: {
                world: 'peace'
              }
            }
          }
        }
      )
    end
  end

  describe 'post_request' do
    it 'simply returns the response for now' do
      response = double('response')

      result = Middleware.post_request.call(response)

      expect(result).to equal(response)
    end
  end

  describe 'reject_request' do
  end
end
