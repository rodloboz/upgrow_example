# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImmutableStruct do
  describe '.new' do
    it 'creates a new Struct class with the given members as keyword arguments' do
      struct_class = described_class.new(:abc, :xyz)
      struct = struct_class.new(abc: 123, xyz: 456)

      expect(struct.members).to match(%i[abc xyz])
      expect(struct.values).to match([123, 456])
      expect(struct).to be_frozen
    end

    it 'accepts symbols only' do
      expect do
        described_class.new('invalid', :member1, :member2)
      end.to raise_error(ArgumentError).with_message('all members must be symbols')
    end
  end

  it 'does not respond to []=' do
    struct = described_class.new(:a_key).new(a_key: 'a_value')
    expect(struct).not_to respond_to(:[]=)
  end

  it 'does not allow members to be mutated' do
    struct_class = described_class.new(:abc, :xyz)
    struct = struct_class.new(abc: 123, xyz: 456)

    expect(struct).not_to respond_to(:abc=)
    expect(struct).not_to respond_to(:xyz=)
  end

  it '#new requires all members' do
    struct_class = described_class.new(:abc, :xyz)

    expect do
      struct_class.new(abc: 'a value')
    end.to raise_error(KeyError).with_message(/key not found: :xyz/)
  end
end
