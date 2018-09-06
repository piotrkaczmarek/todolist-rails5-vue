Rails.application.routes.draw do
  root "landing#index"

  resources :items, only: [:index, :create, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
