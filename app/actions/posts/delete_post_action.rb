# frozen_string_literal: true

module Posts
  class DeletePostAction < BaseAction
    def perform(id)
      PostsRepository.new.delete(id)
      result.success
    end
  end
end
