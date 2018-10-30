class PostsController < ApplicationController
  def create
    @post = PostService.create(post_params)

    if @post.errors.empty?
      render json: @post, status: 200
    else
      render json: @post.errors, status: 422
    end
  end

  private

  def post_params
    params.require(:post).permit(:header, :body, :ip, :user_login)
  end
end
