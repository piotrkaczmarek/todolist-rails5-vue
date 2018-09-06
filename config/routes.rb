Rails.application.routes.draw do
  root "landing#index"

  resources :items, only: [:index, :create, :update, :destroy] do
    member do
      post :upvote
      post :downvote
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
