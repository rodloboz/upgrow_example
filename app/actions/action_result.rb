# frozen_string_literal: true

class ActionResult < ImmutableStruct
  class << self
    def new(*members)
      super(*members, :errors)
    end

    def success(*values)
      new(*values)
    end

    def failure(errors)
      values = members.index_with { |_member| nil }
      new(**values.merge(errors: errors))
    end
  end

  def and_then
    yield(**to_h.except(:errors)) if errors.none?
    self
  end

  def or_else
    yield(errors) if errors.any?
    self
  end

  private

  def initialize(*args)
    values = { errors: [] }.merge(args.first || {})
    super(**values)
  end
end
