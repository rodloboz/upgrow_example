# frozen_string_literal: true

class PostInput < BaseInput
  attribute :title
  attribute :body

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
end
