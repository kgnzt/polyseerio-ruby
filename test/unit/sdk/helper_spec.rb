require 'sdk/helper'

RSpec.describe SdkHelper do
  describe 'resolve_eid' do
    it 'returns the environment if in options has' do
      options = { environment: 'alpha' }

      result = SdkHelper.resolve_eid options

      expect(result).to eq('alpha')
    end

    it 'returns nil if nothing can be deduced' do
      options = { deduce: false }

      result = SdkHelper.resolve_eid options

      expect(result).to be nil
    end

    it 'if deduce is true the env will be used' do
    end

    it 'if deduce is true but there is no env it will return nil' do
    end
  end
end
