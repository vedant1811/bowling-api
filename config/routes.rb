Rails.application.routes.draw do
  resources :games, only: [:create, :show] do
    post :new_ball
  end
end
