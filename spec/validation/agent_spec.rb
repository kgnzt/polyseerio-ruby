require 'polyseerio'
require 'matchers'
require 'validation/helpers'
require 'validation/shared_context'

RSpec.describe Helpers::Validation.client do
  include_context 'validation environment'

  it 'can start an agent' do
    promise = client.start_agent

    promise.execute.value

    expect(promise).to be_fulfilled
  end
end
