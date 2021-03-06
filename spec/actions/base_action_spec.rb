# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BaseAction do
  it 'result_class is an empty ActionResult by default' do
    expect(described_class.result_class.members).to eq(%i[errors])
  end

  it '.result sets the members in the ActionResult class' do
    result_class = described_class.result_class
    described_class.result(:abc, :xyz)

    expect(described_class.result_class.members).to match(%i[abc xyz errors])

    described_class.result_class = result_class
  end

  it '#result returns the ActionResult class from the BaseAction class' do
    expect(described_class.result_class).to eq(described_class.new.result)
  end
end
