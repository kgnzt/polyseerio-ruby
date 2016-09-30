require 'sdk/helper'

RSpec.describe SdkHelper do
  describe 'reduce_options' do
    it 'simply returns options if no copts or defaults' do
      options = { foo: 'bar' }

      result = SdkHelper.reduce_options options

      expect(result).to eq({ 
        foo: 'bar'
      })
    end

    it 'passed arguments trump copts' do
      options = { foo: 'bar', alpha: 'beta' }
      copts = { foo: 'zing', dork: 'duck' }

      result = SdkHelper.reduce_options(options, copts)

      expect(result).to eq({ 
        foo: 'bar',
        alpha: 'beta',
        dork: 'duck'
      })
    end

    it 'passed arguments trump copts and copts trump defaults ' do
      options = { foo: 'bar', alpha: 'beta' }
      copts = { foo: 'zing', dork: 'duck', pop: 'bam' }
      defaults = { foo: 'wow', dork: 'cork', pork: 'chop' }

      result = SdkHelper.reduce_options(options, copts, defaults)

      expect(result).to eq({
        foo: 'bar',
        alpha: 'beta',
        pop: 'bam',
        dork: 'duck',
        pork: 'chop'
      })
    end
  end

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
