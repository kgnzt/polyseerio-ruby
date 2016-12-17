require 'validation/validation_environment'

RSpec.describe Helpers::Validation.client do
  let(:attributes) do
    {
      name: Helpers::Validation.unique_name
    }
  end

  include_context 'validation environment'

  describe described_class.Instance do
    it_has_behavior 'creatable'
    it_has_behavior 'findable'
    it_has_behavior 'updatable'

    it 'enqueues facts on attach' do
      instance = described_class.create(attributes).execute.value

      instance.set_fact('foo', 'bar')
      instance.set_fact('ping', 'pong')

      # result = instance.attach.execute.value

      # result = instance.detach.execute.value
    end
  end
end
