require 'validation/helpers'

RSpec.shared_context 'validation environment' do
  let(:client) { Helpers::Validation.client }

  # Attributes that can be shared.
  let(:logic_attribute) do
    {
      or: [
        { :'===' => [{ pointer: 'group' }, 'error'] },
        { :'===' => [{ pointer: 'group' }, 'warn'] }
      ]
    }
  end
  let(:name_attribute) do
    Helpers::Validation.unique_name
  end

  before(:each) { Helpers::Validation.setup client }
  after(:each) { Helpers::Validation.teardown client }
end
