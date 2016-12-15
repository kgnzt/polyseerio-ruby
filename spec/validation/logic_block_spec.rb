require 'validation/validation_environment'

RSpec.describe Helpers::Validation.client do
  let(:attributes) do
    {
      name: name_attribute,
      logic: logic_attribute
    }
  end

  include_context 'validation environment'

  describe described_class.LogicBlock do
    it_has_behavior 'creatable'
    it_has_behavior 'findable'
    it_has_behavior 'updatable'
  end
end
