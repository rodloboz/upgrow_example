# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostRecord, type: :model do
  it { expect(described_class).to be < BaseRecord }

  describe 'db_columns' do
    it { is_expected.to have_db_column(:title).of_type(:string) }
    it { is_expected.to have_db_column(:body).of_type(:text) }
  end
end
