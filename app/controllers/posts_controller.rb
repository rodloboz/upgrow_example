# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = ListPostsAction.new.perform.posts
  end

  def show
    @post = ShowPostAction.new.perform(params[:id]).post
  end

  def new
    @input = PostInput.new
  end

  def create
    @input = PostInput.new(post_params)

    respond_to do |format|
      Posts::CreatePostAction.new.perform(@input)
        .and_then do |post:|
          format.html { redirect_to post_path(post), notice: 'Post was successfully created.' }
          format.json { render :show, status: :created }
        end
        .or_else do |errors|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(@input, partial: 'posts/form',
                                                              locals: { input: @input })
          end
          format.html { render :new }
          format.json { render json: errors, status: :unprocessable_entity }
        end
    end
  end

  def edit
    @post = Posts::EditPostAction.new.peform(params[:id]).post
    @input = PostInput.new(title: @post.title, body: @post.body)
  end

  def update
    @input = PostInput.new(post_params)

    respond_to do |format|
      if @input.valid?
        post = PostsRepository.new.update(params[:id], @input)
        format.html { redirect_to post_path(post), notice: 'Post was successfully updated.' }
        format.json { render :show, status: :created }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(@input, partial: 'posts/form',
                                                            locals: { input: @input })
        end
        format.html { render :new }
        format.json { render json: @input.errors, status: :bad_request }
      end
    end
  end

  def destroy
    PostsRepository.new.delete(params[:id])
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.require(:post_input).permit(:title, :body)
  end
end
