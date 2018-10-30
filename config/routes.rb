Rails.application.routes.draw do
  resource :posts, only: [:create] do
    post :create_mark
    get :give_top_posts
  end
end
