require 'validation/validation_environment'

RSpec.describe Helpers::Validation.client do
  let(:attributes) do
    {
      name: Helpers::Validation.unique_name,
      protocol: 'smtp',
      recipients: ['foo@bar.com']
    }
  end

  include_context 'validation environment'

  describe described_class.Alert do
    it_has_behavior 'creatable'
    it_has_behavior 'findable'
    it_has_behavior 'updatable'
  end
end
