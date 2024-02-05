# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  devise_for :users, only: [:registrations], controllers: { registrations: 'users/registrations' }
  devise_for :users, only: [:sessions], controllers: { sessions: 'users/sessions' }

  resources :projects, controller: 'api/v1/projects' do
    resources :tasks, controller: 'api/v1/tasks'
  end
end
