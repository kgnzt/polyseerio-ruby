# Ensure that a promise was fulfilled.
RSpec::Matchers.define :be_fulfilled do
  match(&:fulfilled?)

  failure_message_for_should do |actual|
    'expected that promise would be a fulfilled but was ' \
      "#{actual.state}: #{actual.reason}"
  end
end

# Ensure that a promise was rejected.
RSpec::Matchers.define :be_rejected do
  match(&:rejected?)

  failure_message_for_should do |actual|
    "expected that promise would be a rejected but was #{actual.state}"
  end
end
