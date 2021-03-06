# frozen_string_literal: true

class ImmutableObject
  @attribute_names = []

  class << self
    attr_reader :attribute_names

    def attribute(name)
      @attribute_names << name
      attr_reader(name)
    end

    private

    def inherited(subclass)
      super
      subclass.instance_variable_set(:@attribute_names, @attribute_names.dup)
    end
  end

  def initialize(**args)
    absent_attributes = args.keys - self.class.attribute_names

    raise ArgumentError, "Unknown attribute #{absent_attributes}" if absent_attributes.any?

    args.each do |name, value|
      instance_variable_set("@#{name}", value)
    end

    freeze
  end
end
