# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaseModel do
  let(:sample_model) do
    Class.new(described_class) do
      attribute :sample_abc
      attribute :sample_xyz
    end
  end

  it '#attribute_names includes :id, :created_at, and :updated_at' do
    expect(sample_model.attribute_names).to include(:id, :created_at, :updated_at)
  end

  it '#new requires all attributes' do
    expect do
      sample_model.new(
        sample_abc: 'abc', id: 1, created_at: Time.zone.now, updated_at: Time.zone.now
      )
    end.to raise_error(KeyError).with_message(/key not found: :sample_xyz/)
  end
end
