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
      name: Helpers::Validation.unique_name
    }
  end

  describe described_class.Event do
    it_has_behavior 'creatable'
    it_has_behavior 'findable'
  end
end
