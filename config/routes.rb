# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             defaults: { format: :json },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             },
             skip: :all

  devise_scope :user do
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    post   '/signup', to: 'registrations#create'
  end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'locations#index'
  get '/save', to: 'locations#save'
  # delete 'logout', to: 'devise/sessions#destroy'
  resources :locations, only: %i[show create update destroy index]
end
