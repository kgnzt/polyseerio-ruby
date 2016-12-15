require 'validation/validation_environment'

RSpec.describe Helpers::Validation.client do
  let(:attributes) do
    {
      name: Helpers::Validation.unique_name
    }
  end

  include_context 'validation environment'

  describe described_class.Event do
    it_has_behavior 'creatable'
    it_has_behavior 'findable'
  end
end
