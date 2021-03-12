# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Posts::ListPostsAction.new.perform.posts
  end

  def show
    @post = Posts::ShowPostAction.new.perform(params[:id]).post
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
            render turbo_stream: turbo_stream.replace(
              @input,
              partial: 'posts/form',
              locals: {
                input: @input,
                url: posts_path
              }
            )
          end
          format.html { render :new }
          format.json { render json: errors, status: :unprocessable_entity }
        end
    end
  end

  def edit
    @post = Posts::EditPostAction.new.perform(params[:id]).post
    @input = PostInput.new(title: @post.title, body: @post.body)
  end

  def update
    @input = PostInput.new(post_params)

    respond_to do |format|
      Posts::UpdatePostAction.new.perform(params[:id], @input)
        .and_then do |post:|
          format.html { redirect_to post_path(post), notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok }
        end
        .or_else do |errors|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace(
              @input,
              partial: 'posts/form',
              locals: {
                input: @input,
                url: post_path(params[:id]),
              }
            )
          end
          format.html { render :edit }
          format.json { render json: errors, status: :bad_request }
        end
    end
  end

  def destroy
    Posts::DeletePostAction.new.perform(params[:id])
    redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  def post_params
    params.require(:post_input).permit(:title, :body)
  end
end
