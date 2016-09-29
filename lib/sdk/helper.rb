# SDK helper methods
module SdkHelper
  # Determine the eid given a reduced options hash
  def self.resolve_eid(options)
    return options[:environment] if options.key? :environment

    if options[:deduce]
    end

    nil
  end
end
