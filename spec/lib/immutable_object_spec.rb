# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ImmutableObject do
  let(:sample_class) do
    Class.new(described_class) do
      attribute :sample_abc
      attribute :sample_xyz
    end
  end
  let(:subsample_class) do
    Class.new(sample_class) do
      attribute :subsample_abc
    end
  end

  it '#attribute_names is empty by default' do
    expect(described_class.attribute_names).to be_empty
  end

  it '#attribute_names returns a list of attribute names' do
    expect(subsample_class.attribute_names).to contain_exactly(:sample_abc, :sample_xyz, :subsample_abc)
  end

  it '#new creates a frozen instance with the given attributes' do
    sample = sample_class.new(sample_abc: 'abc', sample_xyz: 'xyz')

    expect(sample.sample_abc).to eq('abc')
    expect(sample.sample_xyz).to eq('xyz')
    expect(sample).to be_frozen
  end

  it 'does not allow attributes to be mutated' do
    sample = sample_class.new(sample_abc: 'abc', sample_xyz: 'xyz')

    expect(sample.sample_abc).not_to respond_to(:sample_abc=)
    expect(sample.sample_xyz).not_to respond_to(:sample_xy=)
  end

  it '#new rejects attributes that do not exist' do
    expect do
      sample_class.new(sample_abc: 'abc', sample_xyz: 'xyz', fake: 'error')
    end.to raise_error(ArgumentError).with_message('Unknown attribute [:fake]')
  end

  it '#new adds inherited attributes' do
    subsample = subsample_class.new(
      sample_abc: 'abc', sample_xyz: 'xyz', subsample_abc: 'sub_abc'
    )

    expect(subsample.sample_abc).to eq('abc')
    expect(subsample.sample_xyz).to eq('xyz')
    expect(subsample.subsample_abc).to eq('sub_abc')
  end
end
