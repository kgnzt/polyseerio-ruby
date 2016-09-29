# Helper methods for building and working with resources
module ResourceHelper
  EID_REGEX = Regexp.new('/environments/([a-zA-Z0-9]*)/')

  # Given a request path an eid is returned or nil
  def self.get_eid_from_resource_path(path)
    result = EID_REGEX.match path

    return result if result.nil?

    result[1]
  end

  # True if the response is a resource based response
  def self.resource_response?(response)
    response.key?(:data) &&
      (response[:data].is_a?(Array) || response[:data].is_a?(Hash))
  end

  # True if the response data is a resource collection
  def self.resource_collection?(data)
    data.is_a? Array
  end
end
