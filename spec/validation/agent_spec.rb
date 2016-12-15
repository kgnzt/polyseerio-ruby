require 'polyseerio'
require 'validation/helpers'
require 'validation/shared_context'

RSpec.describe Helpers::Validation.client do
  include_context 'validation environment'

  it 'can start and stop an agent successfuly' do
    client.start_agent
  end
end
