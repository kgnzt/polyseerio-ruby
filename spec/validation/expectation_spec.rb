require 'validation/validation_environment'

RSpec.describe Helpers::Validation.client do
  let(:instance) do
    client.Instance.create(name: Helpers::Validation.unique_name).execute.value
  end

  let(:attributes) do
    {
      name: name_attribute,
      determiner: Polyseerio::Enum::Determiner::ONE,
      is_on: false,
      subject: Polyseerio::Enum::Type::INSTANCE,
      subjects: [instance.id],
      logic: logic_attribute
    }
  end

  include_context 'validation environment'

  describe described_class.Expectation do
    it_has_behavior 'creatable'
    it_has_behavior 'findable'
    it_has_behavior 'updatable'
  end
end
