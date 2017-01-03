require 'polyseerio'

RSpec.describe Polyseerio do
  let(:token) { 'alpha-beta-gamma' }
  let(:client) { Polyseerio.make(token: token) }
  let(:instance) { client.Instance.new }

  it 'can add facts (for later pushing via attach)' do
    instance.add_fact(:foo, 'bar')
    instance.add_fact(:alpha, 'beta')

    expect(instance._facts).to eq(
      foo: 'bar',
      alpha: 'beta'
    )
  end
end
