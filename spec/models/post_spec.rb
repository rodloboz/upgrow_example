# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { described_class }

  it { is_expected.to define_attribute(:id) }
  it { is_expected.to define_attribute(:created_at) }
  it { is_expected.to define_attribute(:updated_at) }
  it { is_expected.to define_attribute(:title) }
  it { is_expected.to define_attribute(:body) }
end
