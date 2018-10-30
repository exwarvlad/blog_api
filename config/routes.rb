Rails.application.routes.draw do
  resource :posts, only: [:create] do
    post :create_mark
  end
end
