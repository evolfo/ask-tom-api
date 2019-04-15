Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :create, :show]
      resources :tools, only: [:index, :create, :show]
      resources :ideas, only: [:index, :create, :show]
      resources :keywords, only: [:index, :create, :show]
    end
  end
end
