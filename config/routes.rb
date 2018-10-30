Rails.application.routes.draw do
  resource :posts, only: [:create] do
    post :create_mark
    post :give_top_posts
  end
end
