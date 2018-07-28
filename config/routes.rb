Rails.application.routes.draw do
  resources :games, only: [:create, :show]
end
