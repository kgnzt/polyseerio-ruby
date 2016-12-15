require 'polyseerio'
require 'validation/helpers'
require 'validation/spec_helper'
require 'validation/shared_examples'

RSpec.describe Helpers::Validation.client do
  let(:client) { Helpers::Validation.client }

  before(:each) { Helpers::Validation.setup client }
  after(:each) { Helpers::Validation.teardown client }

  let(:attributes) do
    {
      name: Helpers::Validation.unique_name,
      protocol: 'smtp',
      recipients: ['foo@bar.com']
    }
  end

  describe described_class.Alert do
    it_has_behavior 'creatable'
    it_has_behavior 'findable'
    it_has_behavior 'updatable'
  end
end
