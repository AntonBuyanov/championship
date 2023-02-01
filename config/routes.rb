Rails.application.routes.draw do
  resources :matches, only: [:index, :show]
  resources :achievements, only: [:index, :show]
  resources :teams, only: [:index, :show]

  resources :players, only: [:index, :show] do
    member do
      get :check_achievement
      get :successful_achievement
    end
  end

  resources :indicators, only: [:index] do
    member do
      get :top_players
    end
  end
end
