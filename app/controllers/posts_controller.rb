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
    @mark = PostService.create_mark(post_mark_params)

    if @mark
      render json: @mark, status: 200
    else
      render json: 'ups', status: 422
    end
  end

  def give_top_posts
    @result = PostService.give_top_posts(top_posts_params)

    if @result
      render json: @result, status: 200
    else
      render json: 'ups', status: 422
    end
  end

  def give_ip_list
    ips = PostService.give_ip_list

    render json: ips, status: 200
  end

  private

  def post_params
    params.require(:post).permit(:header, :body, :ip, :user_login)
  end

  def post_mark_params
    params.require(:post).permit(:num, :post_id)
  end

  def top_posts_params
    params.require(:post).permit(:n)
  end
end
