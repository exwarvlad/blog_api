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

    def give_top_posts(params)
      return false if params[:n].nil? || params[:n].to_i < 0
      top_n = Post.joins(:marks)
                  .group(:post_id)
                  .order('avg(num)')
                  .pluck('post_id, avg(num)')
                  .last(params[:n].to_i)
      Post.where(id: top_n.map(&:first)).pluck(:header, :body, :id)
    end

    def give_ip_list
      # select all uniq ips
      ips = Post.select(:ip).distinct.pluck(:ip)
      # find all logins by ip and map to [[ip1, [login1, login]]...]
      ips.map! { |item| [item, User.joins(:posts).where('posts.ip = ?', item.to_s).pluck(:login)] }
      # clear item if logins size == 1
      ips.reject! { |item| item.second.size == 1 }
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