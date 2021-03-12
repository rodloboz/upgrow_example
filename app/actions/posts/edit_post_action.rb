# frozen_string_literal: true

module Posts
  class EditPostAction < BaseAction
    result :post

    def perform(id)
      result.success(post: PostsRepository.new.find(id))
    end
  end
end
