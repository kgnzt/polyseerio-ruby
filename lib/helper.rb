require 'inflection'

module Polyseerio
  # General helper functions for SDK
  module Helper
    DEFAULT_REQUIRE_DIRECTORY_OPTIONS = {
      exclude: ['index'].freeze
    }.freeze

    # Simple conversion to seconds from ms.
    def self.ms_to_seconds(ms)
      ms / 1000.0
    end

    # Given directory and module a map of module procs will be created.
    # TODO: this is really a dir func map not a proc map
    def self.dir_proc_map(dir, mod)
      map = Polyseerio::Helper.dir_to_path_map dir

      map.each { |(_, path)| require path }

      map.each_with_object({}, &Helper.add_to_proc_map(mod))
    end

    # Adds a proc method to an accumulator by its name.
    # TODO: this is really a dir func map not always a proc map.
    def self.add_to_proc_map(*args)
      proc do |mod, (name, _), acc|
        if mod.respond_to? name
          result = mod.send name

          acc[name] = result unless result.nil?
        end

        acc
      end.curry.call(*args)
    end

    # Convert resource string to resource type.
    def self.resource_to_type(resource)
      Inflection.singular(resource)
    end

    # A memoize function that has an optional cache key.
    def self.memoize_function(func, get_key)
      lambda do
        results = {}

        proc do |*args|
          key = get_key.call(*args) # TODO: assert key is sym?

          if results.key? key
            results.fetch key
          else
            result = func.call(*args)

            results[key] = result

            result
          end
        end
      end.call
    end

    # Simple identity function.
    def self.identity(value)
      proc { |x| x }.call(value)
    end

    # Maps filename to file path
    def self.dir_to_path_map(directory, options = {})
      directory = "#{directory}/*#{options[:extension]}"
      options = defaults(options, DEFAULT_REQUIRE_DIRECTORY_OPTIONS)

      paths = Dir[directory].select do |file|
        name = File.basename(file, '.*')

        !options[:exclude].include? name
      end

      paths.each_with_object({}) do |file, acc|
        name = File.basename(file, '.*')

        acc[name.to_sym] = file

        acc
      end
    end

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
