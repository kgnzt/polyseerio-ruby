require 'polyseerio'
require 'validation/helpers'
require 'validation/spec_helper'
require 'validation/shared_examples'

RSpec.describe Helpers::Validation.client do
  before(:all) { Helpers::Validation.setup described_class }
  after(:all) { Helpers::Validation.teardown described_class }

  let(:attributes) do
    {
      name: Helpers::Validation.unique_name
    }
  end

  describe described_class.Instance do
    it_has_behavior 'creatable'
    it_has_behavior 'findable'
    it_has_behavior 'updatable'
  end
end
