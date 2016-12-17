require 'polyseerio'

RSpec.describe Polyseerio do
  let(:token) { 'alpha-beta-gamma' }
  let(:client) { Polyseerio.make(token: token) }
  let(:instance) { client.Instance.new }

  it 'can set facts' do
    instance.set_fact(:foo, 'bar')
    instance.set_fact(:alpha, 'beta')

    expect(instance.facts).to eq(
      foo: 'bar',
      alpha: 'beta'
    )
  end
end
