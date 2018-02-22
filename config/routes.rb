Rails.application.routes.draw do

  resources :application_settings
  resources :authentication_providers
  namespace :api do
    resources :canaries
  end

  resources :alert_integrations
  get 'checkin/:team_id/:id', to: 'checkin#create'
  post 'checkin/:team_id/:id', to: 'checkin#create'

  resources :canaries
  resources :teams

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  devise_scope :user do
    delete 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  scope :admin do
    resources :users
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'welcome#index'
end
