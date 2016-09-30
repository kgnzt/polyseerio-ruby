require 'resource/definition'

DEFINTION = ResourceDefinition::DEFINITION

# Functions and factory for building resources
module ResourceFactory
  # Determine if a resource definition represents a singleton
  def self.singleton_definition?(definition)
    !definition.key?(:methods) || definition[:methods].empty?
  end

  # Add a static method to a Class
  def self.add_static(resource, method, name)
    resource.class_eval do
      define_singleton_method(name, &method)
    end
  end

  # Add an instance method to a Class
  def self.add_method(resource, method, name)
    resource.class_eval do
      define_method(name, &method)
    end
  end

  # Add a collection of static methods to a Class
  def self.add_statics(resource, statics = [])
    return resource if statics.empty?

    statics.reduce(resource, &add_static)
  end

  # Add a collection of instance methods to a Class
  def self.add_methods(resource, methods = [])
    return resource if methods.empty?

    methods.reduce(resource, &add_method)
  end

  # Create a resource
  def self.make(resource, request, cid, options = {})
    raise ArgumentError, "Could not find definition for resource: #{resource}" if !DEFINITION.key? resource
  end

  # Generate a memoize key based on factory arguments
  def self.get_memoize_key(resource, _, cid, _)
    "#{resource}.#{cid}"
  end

  # memoize(:factory?)
end
