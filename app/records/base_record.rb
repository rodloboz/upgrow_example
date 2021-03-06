# frozen_string_literal: true

# rubocop:disable Rails/ApplicationRecord
class BaseRecord < ActiveRecord::Base
  self.abstract_class = true
end
# rubocop:enable Rails/ApplicationRecord
