# frozen_string_literal: true

module Posts
  class ShowPostAction < BaseAction
    result :post

    def perform(id)
      result.success(post: PostRepository.new.find(id))
    end
  end
end
