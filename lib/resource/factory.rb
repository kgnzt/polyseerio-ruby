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
end
