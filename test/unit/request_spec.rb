require 'request'

RSpec.describe Polyseerio::Request do
  let(:resource) { double('resource') }
  let(:request) { described_class.new(resource) }
  let(:result_double) { double('result') }
  let(:resource_path_double) { double('resource_path') }
  let(:route) { '/foo/bar' }
  let(:payload) { { fat: 'chance' } }
  let(:options) { { ding: 'dong' } }

  describe 'middleware interactions' do
    it 'correctly scopes the resource path when just a path is passed' do
      allow(resource).to receive(:[]).and_return(resource_path_double)
      allow(resource_path_double).to receive(:get).and_return(result_double)

      request = described_class.new(resource)

      request.get(route).execute.value

      expect(resource).to have_received(:[]).with(route)
    end

    it 'correctly scopes and forwards arguments when path, payload, options' do
      allow(resource).to receive(:[]).and_return(resource_path_double)
      allow(resource_path_double).to receive(:get).and_return(result_double)

      request = described_class.new(resource)

      request.get(route, payload, options).execute.value

      expect(resource).to have_received(:[]).with(route)
      expect(resource_path_double).to have_received(:get).with(payload, options)
    end

    it 'correctly handles pre middleware' do
      allow(resource).to receive(:[]).and_return(resource_path_double)
      allow(resource_path_double).to receive(:get).and_return(result_double)

      request = described_class.new(resource, pre: [proc do |_, __|
        ['zoo', { alpha: 'beta' }]
      end])

      request.get(route, options).execute.value

      expect(resource_path_double).to have_received(:get).with(alpha: 'beta')
    end

    it 'correctly handles post middleware' do
      allow(resource).to receive(:[]).and_return(resource_path_double)
      allow(resource_path_double).to receive(:get).and_return(result_double)

      request = described_class.new(resource, post: [proc do |_|
        { wild: 'wizard' }
      end])

      result = request.get(route, options).execute.value

      expect(result).to eq(wild: 'wizard')
    end
  end

  describe 'get' do
    before do
      allow(resource).to receive(:[]).and_return(resource_path_double)
      allow(resource_path_double).to receive(:get).and_return(result_double)
    end

    it 'forwards to request.get' do
      options = {
        ding: 'dong'
      }

      result = request.get(route, options).execute.value

      expect(resource).to have_received(:[]).with(route)
      expect(resource_path_double).to have_received(:get).with(options)
      expect(result). to equal(result_double)
    end
  end

  describe 'post' do
    before do
      allow(resource).to receive(:[]).and_return(resource_path_double)
      allow(resource_path_double).to receive(:post).and_return(result_double)
    end

    it 'forwards to request.post' do
      options = {
        ding: 'dong'
      }

      result = request.post(route, options).execute.value

      expect(resource).to have_received(:[]).with(route)
      expect(resource_path_double).to have_received(:post).with(options)
      expect(result). to equal(result_double)
    end
  end

  describe 'put' do
    before do
      allow(resource).to receive(:[]).and_return(resource_path_double)
      allow(resource_path_double).to receive(:put).and_return(result_double)
    end

    it 'forwards to request.put' do
      options = {
        ding: 'dong'
      }

      result = request.put(route, options).execute.value

      expect(resource).to have_received(:[]).with(route)
      expect(resource_path_double).to have_received(:put).with(options)
      expect(result). to equal(result_double)
    end
  end

  describe 'delete' do
    before do
      allow(resource).to receive(:[]).and_return(resource_path_double)
      allow(resource_path_double).to receive(:delete).and_return(result_double)
    end

    it 'forwards to request.delete' do
      options = {
        ding: 'dong'
      }

      result = request.delete(route, options).execute.value

      expect(resource).to have_received(:[]).with(route)
      expect(resource_path_double).to have_received(:delete).with(options)
      expect(result). to equal(result_double)
    end
  end

  describe described_class::Middleware do
    it 'defines PRE' do
      expect(described_class::PRE).to eq(:pre)
    end

    it 'defines POST' do
      expect(described_class::POST).to eq(:post)
    end

    it 'defines REJECT' do
      expect(described_class::REJECT).to eq(:reject)
    end
  end
end
