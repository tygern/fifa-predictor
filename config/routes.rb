Rails.application.routes.draw do
  root "welcome#index"

  resources :match_results
  resources :teams
  resources :predictions, only: [:index, :create]
end
