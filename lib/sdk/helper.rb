require 'constant'

module Polyseerio
  module SDK
    # SDK helpers.
    module Helper
      # Accumulates a function type from a map into an accumulator.
      def self.accumulate_procs(*args)
        proc do |type, map, name, acc|
          unless map.key? name
            raise "SDK factory could not find a #{type} #{name}."
          end

          acc[name] = map.fetch(name)

          acc
        end.curry.call(*args)
      end

      # Reduce method options with client options and method defaults
      def self.reduce_options(options, copts = {}, defaults = {})
        defaults.merge(copts).merge(options)
      end

      # Determine the eid given a reduced options hash
      def self.resolve_eid(options)
        return options[:environment] if options.key? :environment

        if options[:deduce]
          env = options.fetch(:env)

          return ENV.fetch env if ENV.key? env
        end

        Constant::DEFAULT_ENVIRONMENT
      end
    end
  end
end
