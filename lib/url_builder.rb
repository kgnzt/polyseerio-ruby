require 'functional'
require 'constant'
require 'resource'

module UrlBuilder
  include Functional::Memo

  # Resources that are mapped to environments.
  RoutableResources = [
    Resource::ALERT,
    Resource::EVENT,
    Resource::EXPECTATION,
    Resource::INSTANCE,
    Resource::TASK
  ]

  # Determine if a resource is routable to an environment.
  def self.is_routable_resource(resource)
    RoutableResources.include? resource
  end

  # Generate a base API url.
  def self.get_base_url(
    base     = Constant::DEFAULT_API_BASE_URL, 
    protocol = Constant::DEFAULT_API_PROTOCOL, 
    version  = Constant::DEFAULT_API_VERSION
  )
    "#{protocol}#{base}/#{version}"
  end

  # Get a resource's path.
  def self.get_resource_path(resource, options = {})
    environment = ''

    if is_routable_resource resource
      if !options.include? :eid
        raise ArgumentError, "Cannot get routable resource path for #{resource} without passing an eid to options."
      end

      environment = "environments/%{eid}/" % options
    end

    id = (options.include? :id) ? ("/%{id}" % options) : '';

    "/#{environment}#{resource}#{id}"
  end

  memoize(:is_routable_resource)
  memoize(:get_resource_path)
end
