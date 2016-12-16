# Ensure that a promise was fulfilled.
RSpec::Matchers.define :be_fulfilled do
  match(&:fulfilled?)

  failure_message do |actual|
    'expected that promise would be a fulfilled but was ' \
      "#{actual.state}: #{actual.reason}"
  end
end

# Ensure that a promise was fulfilled with the correct reason.
RSpec::Matchers.define :be_fulfilled_with do |expected|
  match do |actual|
    actual.fulfilled? && actual.value == expected
  end

  failure_message do |actual|
    if actual.fulfilled?
      'expected that promise would be a fulfilled with ' \
      "#{expected} but was #{actual.value}"
    else
      "expected that promise would be a fulfilled but was #{actual.state}"
    end
  end
end

# Ensure that a promise was rejected.
RSpec::Matchers.define :be_rejected do
  match(&:rejected?)

  failure_message do |actual|
    "expected that promise would be a rejected but was #{actual.state}"
  end
end

# Ensure that a promise was rejected with the correct reason.
RSpec::Matchers.define :be_rejected_with do |expected|
  match do |actual|
    actual.rejected? && actual.reason == expected
  end

  failure_message do |actual|
    if actual.rejected?
      'expected that promise would be a rejected with ' \
      "#{expected} but was #{actual.reason}"
    else
      "expected that promise would be a rejected but was #{actual.state}"
    end
  end
end
