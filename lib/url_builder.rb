require 'functional'
require_relative 'resource'

module UrlBuilder
  include Functional::Memo

  RoutableResources = [
    Resource::ALERT,
    Resource::EVENT,
    Resource::EXPECTATION,
    Resource::INSTANCE,
    Resource::TASK
  ]

  def self.is_routable_resource(resource)
    RoutableResources.include? resource
  end

  def self.get_resource_path(resource, options = {})
    environment = ''

    if is_routable_resource resource
      if true

      end

      environment = "environments/%{eid}" % options
    end

    "/%{environment}%{resource}${id}"
  end

  memoize(:is_routable_resource)
end
