# frozen_string_literal: true

module Posts
  class DeletePostAction < BaseAction
    def perform(id)
      PostRepository.new.delete(id)
      result.success
    end
  end
end
