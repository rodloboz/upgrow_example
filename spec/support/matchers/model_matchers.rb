# frozen_string_literal: true

RSpec::Matchers.define :define_attribute do |attribute|
  match do |klass|
    klass.attribute_names.include?(attribute)
  end

  failure_message do |klass|
    "#{klass} does not have attribute #{attribute}}."
  end

  failure_message_when_negated do |klass|
    "#{klass} has attribute #{attribute}."
  end
end
