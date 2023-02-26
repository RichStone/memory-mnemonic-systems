Rails.application.routes.draw do
  resources :major_systems
  resources :pegs

  namespace :public do
    resources :major_systems, only: [:index, :show]
    resource :homepage, only: :show
  end

  devise_for :brains
  namespace :brain do
    resources :major_systems, only: [:index, :show, :destroy]
    resources :pegs, only: [:edit, :update]
    resources :conversions, only: [:new, :create]
  end

  root "public/homepages#show"
end
