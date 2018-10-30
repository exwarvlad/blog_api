module PostService
  class << self
    def create(params)
      Post.create(set_params_with_user(params))
    end

    def create_mark(params)
      post = Post.find_by(id: params[:post_id])

      if post
        mark = Mark.create(num: params[:num], post_id: post.id)
        if mark.errors.empty?
          check_average_sum(post.id)
        else
          false
        end
      else
        false
      end
    end

    private

    def set_params_with_user(params)
      user = User.find_by(login: params[:user_login])

      if user
        params.delete(:user_login)
        params[:user_id] = user.id
        params
      else
        params.merge!(user_attributes: { login: params.delete(:user_login) })
      end
    end

    def check_average_sum(post_id)
      Mark.where(post_id: post_id).average(:num).to_f.round(2)
    end
  end
end