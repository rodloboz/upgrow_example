# frozen_string_literal: true

module Posts
  class ListPostsActions < BaseAction
    result :posts

    def perform
      result.success(posts: PostRepository.new.all)
    end
  end
end
