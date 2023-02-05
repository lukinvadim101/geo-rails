# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    devise_scope :user do
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      post   '/signup', to: 'registrations#create'
    end

    get '/checkin', to: 'locations#checkin'
    get '/locations', to: 'locations#index'
    get '/locations/:id', to: 'locations#show'
    post '/locations', to: 'locations#create'
    put '/locations/:id', to: 'locations#update'
    delete '/locations/:id', to: 'locations#destroy'
  end

  scope :api, defaults: { format: :json } do
    devise_for :users, path: 'api/users',
                       controllers: { sessions: 'api/sessions',
                                      registrations: 'api/registrations' },
                       skip: :all
  end

  mount RailsAdmin::Engine => 'api/admin', as: 'rails_admin'

  root 'api/locations#index'
end
