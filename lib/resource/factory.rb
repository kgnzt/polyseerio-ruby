# Functions and factory for building resources
module ResourceFactory
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
  def.self.factory (resource, request, cid, options = {})
  end
end
