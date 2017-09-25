Rails.application.routes.draw do

  namespace :api do
    resources :canaries
  end

  resources :alert_integrations
  get 'checkin/:team_id/:id', to: 'checkin#create'
  post 'checkin/:team_id/:id', to: 'checkin#create'

  resources :canaries
  resources :teams

  devise_for :users

  scope :admin do
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'welcome#index'
end
