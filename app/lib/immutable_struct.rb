# frozen_string_literal: true

# rubocop:disable Style/IfUnlessModifier
class ImmutableStruct < Struct
  class << self
    def new(*args, &block)
      if args.any? { |member| !member.is_a?(Symbol) }
        raise ArgumentError, 'all members must be symbols'
      end

      struct_class = super(*args, keyword_init: true, &block)

      struct_class.members.each do |member|
        struct_class.send(:undef_method, :"#{member}=")
      end

      struct_class
    end
  end

  undef []=

  def initialize(**args)
    members.each { |key| args.fetch(key) }
    super(**args)
    freeze
  end
end
# rubocop:enable Style/IfUnlessModifier
