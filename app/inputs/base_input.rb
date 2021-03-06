# frozen_string_literal: true

class BaseInput
  include ActiveModel::Model

  @attribute_names = []

  class << self
    attr_reader :attribute_names

    def attribute(name)
      @attribute_names << name
      attr_accessor(name)
    end

    private

    def inherited(subclass)
      super
      subclass.instance_variable_set(:@attribute_names, @attribute_names.dup)
    end
  end

  def attributes
    instance_values.symbolize_keys.slice(*self.class.attribute_names)
  end
end
