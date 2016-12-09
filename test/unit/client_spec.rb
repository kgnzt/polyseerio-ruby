require 'Client'

RSpec.describe Client do
  describe 'initialize' do
    it 'raises an error without a cid' do
      expect { Client.new }.to raise_error(
        ArgumentError,
        /wrong number of arguments/
      )
    end

    it 'sets the cid to passed cid' do
      cid = 0
      client = Client.new(cid, request: {})

      expect(client.cid).to eq(cid)
    end

    it 'defaults the agent to nil' do
      client = Client.new(0, request: {})

      expect(client.agent).to be_nil
    end

    it 'raises an error if no request is passed' do
      expect { Client.new(1, {}) }.to raise_error(
        ArgumentError,
        /Cannot create an instance of Client without/
      )
    end
  end
end
