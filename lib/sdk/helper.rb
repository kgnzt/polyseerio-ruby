# SDK helper methods
module SdkHelper
  # Reduce method options with client options and method defaults
  def self.reduce_options(options, copts = {}, defaults = {})
    defaults.merge(copts).merge(options)
  end

  # Determine the eid given a reduced options hash
  def self.resolve_eid(options)
    return options[:environment] if options.key? :environment

    if options[:deduce]
    end

    nil
  end
end
