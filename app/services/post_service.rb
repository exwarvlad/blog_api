module PostService
  class << self
    def create(params)
      Post.create(set_params_with_user(params))
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
  end
end