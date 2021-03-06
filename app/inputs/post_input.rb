class PostInput < BaseInput
  attr_accessor :title, :body

  def attributes
    instance_values.symbolize_keys.slice(:title, :body)
  end

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
 end
