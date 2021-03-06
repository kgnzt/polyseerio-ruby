require 'functional'
require 'constant'

module Polyseerio
  # Functions and constants used for formatting and building resource URIs.
  module URL
    include Functional::Memo

    # Resources that are mapped to environments.
    RoutableResources = [
      Enum::Resource::ALERT,
      Enum::Resource::EVENT,
      Enum::Resource::EXPECTATION,
      Enum::Resource::INSTANCE,
      Enum::Resource::TASK
    ].freeze

    # Determine if a resource is routable to an environment.
    def self.routable_resource?(resource)
      RoutableResources.include? resource
    end

    # Generate a base API url.
    def self.get_base_url(base, protocol, version)
      version ||= Constant::DEFAULT_API_VERSION

      "#{protocol}#{base}/#{version}"
    end

    # Get a resource's path.
    def self.get_resource_path(resource, options = {})
      environment = ''

      if routable_resource? resource
        if !options.include?(:eid) || options[:eid].nil?
          raise ArgumentError, 'Cannot get routable resource path for'\
            " #{resource} without passing an eid to options."
        end

        environment = format('environments/%s/', options[:eid])
      end

      id = if options.include?(:id) && !options[:id].nil?
             format('/%s', options[:id])
           else
             ''
           end

      format('/%s%s%s', environment, resource, id)
    end

    memoize(:routable_resource?)
    memoize(:get_resource_path)
  end
end
