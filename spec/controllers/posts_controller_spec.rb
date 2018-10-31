require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  describe 'HTTP POST and GET' do
    let(:post_params) {{post: {header: "x-fa-fafds",
                       body: "yoyoy42",
                       ip:"127.0.0.1",
                       user_login: "Lelm"}}}

    let(:post_mark_params) { {post: { num: 5, post_id: Post.first.id}} }

    let(:top_posts_params) { {post: {n: 5,}} }

    before(:each) do
      post 'create', { params: post_params }
      post 'create_mark', { params: post_mark_params }
    end

    ### POST to action posts ###
    it 'creates a post unit' do
      expect(response.status).to eq(200)
      expect(response.body).not_to be_empty
    end

    it 'failed creates a post' do
      post_params[:post].delete(:ip)
      post 'create', { params: post_params }

      expect(response.status).to eq(422)
      expect(response.body).to include "can't be blank"
    end

    ### POST to action post_mark ###
    it 'creates a post.mark unit' do
      expect(response.status).to eq(200)
      expect(response.body).to eq post_mark_params[:post][:num].to_f.to_s
    end

    it 'failed creates a post.mark unit' do
      post_mark_params[:post][:num] = -1
      post 'create_mark', { params: post_mark_params }

      expect(response.status).to eq(422)
    end

    ### GET to action give_top_posts ###
    it 'give top posts' do
      get 'give_top_posts', { params: top_posts_params }

      expect(response.status).to eq(200)
      expect(response.body).not_to be_empty
    end

    it 'invalide give top posts' do
      top_posts_params[:post][:n] = -1
      get 'give_top_posts', { params: top_posts_params }

      expect(response.status).to eq(422)
      expect(response.body).not_to be_empty
    end

    ### GET to action give_ip_list ###
    it 'give ip list' do
      get 'give_ip_list'

      expect(response.status).to eq(200)
    end
  end
end