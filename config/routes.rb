# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: :all

  devise_for :users,
             path: '',
             path_names: {
               sign_in: '/login',
               sign_out: '/logout',
               registration: '/signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             },
             defaults: { format: :json }

  devise_scope :user do
    scope :auth, defaults: { format: :json } do
      post   '/signin',       to: 'sessions#create'
      delete '/signout',      to: 'sessions#destroy'
      post   '/signup',       to: 'registrations#create'
    end
  end

  # to do custom devise
  # ,skip: %i[sessions registrations]

  # devise_scope :user do
  #   resources :sessions, only: %i[create]
  #   # post 'login', to: 'devise/sessions#create'
  #   # delete '/users/sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  # end

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'locations#index'
  get '/save', to: 'locations#save'
  # delete 'logout', to: 'devise/sessions#destroy'
  resources :locations, only: %i[show create update destroy index]
end
