require 'sdk/static/index'
require 'sdk/method/index'

# Used to create static and instance SDK methods
module SDKFactory
  # Accumulator for static functions.
  def self.accumulate_static(acc, name)
    unless SDK::Static.key? name
      raise ArgumentError, "Could not find SDK static function #{name}"
    end

    acc[name] = SDK::Static[name]

    acc
  end

  # Accumulator for instance methods.
  def self.accumulate_method(acc, name)
    unless SDK::Method.key? name
      raise ArgumentError, "Could not find SDK instance method #{name}"
    end

    acc[name] = SDK::Method[name]

    acc
  end
end
