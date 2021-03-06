# frozen_string_literal: true

module Posts
  class CreatePostAction < BaseAction
    result :post

    def perform(input)
      if input.valid?
        post = PostRepository.new.create(input)
        result.success(post: post)
      else
        result.failure(input.errors)
      end
    end
  end
end
