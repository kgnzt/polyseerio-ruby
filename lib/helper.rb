module Polyseerio
  # General helper functions for SDK
  module Helper
    DEFAULT_REQUIRE_DIRECTORY_OPTIONS = {
      exclude: ['index.rb'].freeze
    }.freeze

    # Load an include an entire directory.
    def self.require_directory(directory, options = {})
      directory = "#{directory}/*#{options[:extension]}"
      options = defaults(options, DEFAULT_REQUIRE_DIRECTORY_OPTIONS)

      Dir[directory].select do |file|
        pathname = Pathname.new(file)

        !options[:exclude].include? pathname.basename
      end
    end

    # Format a resouce payload for API consumption
    def self.format_payload(payload)
      { data: { attributes: payload.clone } }
    end

    # Attempt to geta token.
    def self.resolve_token(options)
      return options[:token] unless options[:token].nil?

      if ENV.key? options[:token_env]
        value = ENV.fetch(options[:token_env], nil)

        return value unless value.nil?
      end

      nil
    end

    # Generates default options.
    def self.defaults(options, *defaults)
      result = {}

      defaults.reverse_each do |opts|
        result.merge!(opts)
      end

      result.merge!(options)
    end

    # Used to attach a method to an instance
    def self.attach_to_instance!(*args)
      lambda do |instance, (key, value)|
        instance.instance_eval do
          define_singleton_method(key, proc { value })
        end
      end.curry.call(*args)
    end

    # Rekey a hash using a remapping hash.
    def self.rekey(hash, map)
      hash.each_with_object({}) do |(key, value), acc|
        if map.key? key
          acc[map[key]] = value
        else
          acc[key] = value
        end

        acc
      end
    end
  end
end
