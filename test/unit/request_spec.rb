require 'request'

RSpec.describe Request do
  let(:resource) { double('resource') }
  let(:request) { Request.new(resource) }
  let(:result_double) { double('result') }

  let(:pre_middleware) do
    [proc { |_| [{ alpha: 'beta' }] }]
  end

  let(:post_middleware) do
    [proc { |_| { zoo: 'animals' } }]
  end

  describe 'initialize' do
    it '' do
    end
  end

  describe 'middleware interactions' do
    before do
      allow(resource).to receive(:get).and_return(result_double)
    end

    it 'correctly handles pre middleware' do
      options = {
        ding: 'dong'
      }

      request = Request.new(resource, pre: pre_middleware)

      request.get options

      expect(resource).to have_received(:get).with(alpha: 'beta')
    end

    it 'correctly handles post middleware' do
      options = {
        ding: 'dong'
      }

      request = Request.new(resource, post: post_middleware)

      result = request.get options

      expect(result).to eq(zoo: 'animals')
    end
  end

  describe 'get' do
    before do
      allow(resource).to receive(:get).and_return(result_double)
    end

    it 'forwards to request.get' do
      options = {
        ding: 'dong'
      }

      result = request.get options

      expect(resource).to have_received(:get).with(options)
      expect(result). to equal(result_double)
    end
  end

  describe 'post' do
    before do
      allow(resource).to receive(:post).and_return(result_double)
    end

    it 'forwards to request.post' do
      options = {
        ding: 'dong'
      }

      result = request.post options

      expect(resource).to have_received(:post).with(options)
      expect(result). to equal(result_double)
    end
  end

  describe 'put' do
    before do
      allow(resource).to receive(:put).and_return(result_double)
    end

    it 'forwards to request.put' do
      options = {
        ding: 'dong'
      }

      result = request.put options

      expect(resource).to have_received(:put).with(options)
      expect(result). to equal(result_double)
    end
  end

  describe 'delete' do
    before do
      allow(resource).to receive(:delete).and_return(result_double)
    end

    it 'forwards to request.delete' do
      options = {
        ding: 'dong'
      }

      result = request.delete options

      expect(resource).to have_received(:delete).with(options)
      expect(result). to equal(result_double)
    end
  end

  describe Request::Middleware do
    it 'defines PRE' do
      expect(Request::Middleware::PRE).to eq(:pre)
    end

    it 'defines POST' do
      expect(Request::Middleware::POST).to eq(:post)
    end

    it 'defines REJECT' do
      expect(Request::Middleware::REJECT).to eq(:reject)
    end
  end
end
