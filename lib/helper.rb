# General helper functions for SDK
module Helper
  # Format a resouce payload for API consumption
  def self.format_payload(payload)
    { data: { attributes: payload.clone } }
  end
end
