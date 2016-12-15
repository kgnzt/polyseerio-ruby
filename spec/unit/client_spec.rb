require 'client'

RSpec.describe Polyseerio::Client do
  let(:agent_class) { double('AgentDouble') }
  let(:agent) { double('agent') }
  let(:cid) { 0 }
  let(:request_double) { double('result') }
  let(:options) { { agent_class: agent_class, request: request_double } }

  describe 'initialize' do
    it 'raises an error without a cid' do
      expect { described_class.new }.to raise_error(
        ArgumentError,
        /wrong number of arguments/
      )
    end

    it 'sets the cid to passed cid' do
      client = described_class.new(cid, request: {})

      expect(client.cid).to eq(cid)
    end

    it 'defaults the agent to nil' do
      client = described_class.new(cid, request: {})

      expect(client.agent).to be_nil
    end

    it 'will attach resources passed' do
      resources = {
        Alpha: double('AlphaDouble'),
        Beta: double('BetaDouble'),
        Gamma: double('GammaDouble')
      }

      client = described_class.new(
        cid,
        request: request_double,
        resources: resources
      )

      expect(client.Alpha). to eq(resources[:Alpha])
      expect(client.Beta). to eq(resources[:Beta])
      expect(client.Gamma). to eq(resources[:Gamma])
    end

    it 'raises an error if no request is passed' do
      expect { described_class.new(cid, {}) }.to raise_error(
        ArgumentError,
        /Cannot create an instance of Client without/
      )
    end
  end

  describe 'start_agent' do
    let(:result_double) { double('result') }
    let(:client) { described_class.new(cid, options) }

    before do
      allow(agent_class).to receive(:new).and_return(agent)
      allow(agent).to receive(:start).and_return(result_double)
    end

    it 'raises a RuntimeError if the agent has already been started' do
      client.start_agent

      expect { client.start_agent }.to raise_error(
        RuntimeError,
        /Agent has already started./
      )
    end

    it 'correctly creates a new agent instance passing itself as client' do
      client.start_agent

      expect(agent_class).to have_received(:new).with(client)
    end

    it 'returns the result of agent.start' do
      result = client.start_agent

      expect(result).to eq(result_double)
    end

    it 'forwards arguments to agent.start' do
      arg_one = 'ding'
      arg_two = 'dong'

      client.start_agent(arg_one, arg_two)

      expect(agent).to have_received(:start).with(arg_one, arg_two)
    end
  end
end
