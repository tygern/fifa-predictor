Rails.application.routes.draw do
  root to: redirect('/predictions')

  resources :match_results
  resources :teams
  resources :predictions, only: [:index, :create]
end
