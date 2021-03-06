# frozen_string_literal: true

class BaseModel < ImmutableObject
  attribute :id
  attribute :created_at
  attribute :updated_at

  def initialize(**args)
    self.class.attribute_names.each { |key| args.fetch(key) }

    super
  end
end
