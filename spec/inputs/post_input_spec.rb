# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostInput, type: :model do
  describe 'attributes' do
    subject { described_class }

    it { is_expected.to define_attribute(:title) }
    it { is_expected.to define_attribute(:body) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }
  end
end
