# frozen_string_literal: true

module Posts
  class UpdatePostAction < BaseAction
    result :post

    def perform(id, input)
      if input.valid?
        post = PostsRepository.new.update(id, input)
        result.success(post: post)
      else
        result.failure(input.errors)
      end
    end
  end
end
