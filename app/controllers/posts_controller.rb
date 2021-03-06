class PostsController < ApplicationController
  def index
    @posts = PostRepository.new.all
  end
end
