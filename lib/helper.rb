# General helper functions for SDK
module Helper
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
end
