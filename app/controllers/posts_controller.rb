class PostsController < ApplicationController
  def create
    @post = PostService.create(post_params)

    if @post.errors.empty?
      render json: @post, status: 200
    else
      render json: @post.errors, status: 422
    end
  end

  def create_mark
    @mark = PostService.create_mark(set_mark)

    if @mark
      render json: @mark.to_s + "\n", status: 200
    else
      render json: 'ups' + "\n", status: 422
    end
  end

  private

  def post_params
    params.require(:post).permit(:header, :body, :ip, :user_login)
  end

  def set_mark
    params.require(:mark).permit(:num, :post_id)
  end
end
