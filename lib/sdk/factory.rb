require 'sdk/static'
require 'sdk/method'

# Used to create static and instance SDK methods
module SdkFactory
  # Accumulator for static functions
  def self.accumulate_static(acc, name)
    raise ArgumentError, "Could not find SDK static function #{name}" 
      unless SDK::Static.key? name

    acc[name] = SDK::Static[name]

    acc
  end

  # Accumulator for instance methods
  def self.accumulate_method(acc, name)
    raise ArgumentError, "Could not find SDK instance method #{name}" 
      unless SDK::Method.key? name
    
    acc[name] = SDK::Method[name]

    acc
  end

  # Create hash of static functions
  def self.static(request, resource, statics = [], options = {})
    statics.reduce(&accumulate_static, {})
  end

  # Create hash of instance methods
  def.self.method(request, resource, statics = [], options = {})
    statics.reduce(&accumulate_method, {})
  end
end
