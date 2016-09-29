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
      (resource?(response[:data]) || resource_collection?(response[:data]))
  end

  # True if response data is a resource collection (alias)
  def self.resource_collection?(data)
    data.is_a? Array
  end

  # True if response data is a resource collection (alias)
  def self.resource?(data)
    data.is_a? Hash
  end

  # Convert parsed response data into an instance
  def to_instance(data, meta, included, cid)
    nil
  end

  # Parse a resource response
  def parse_resource_response(response, cid)
    nil
  end

  # Parse a response
  def self.parse_response(response, cid)
    return parse_resource_response(response, cid) if resource_response? response

    response
  end
end
