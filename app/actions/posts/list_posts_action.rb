# frozen_string_literal: true

module Posts
  class ListPostsAction < BaseAction
    result :posts

    def perform
      result.success(posts: PostsRepository.new.all)
    end
  end
end
