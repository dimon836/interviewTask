# frozen_string_literal: true

# == Route Map
#

Rails.application.routes.draw do
  resources :projects, controller: 'api/v1/projects' do
    resources :tasks, controller: 'api/v1/tasks'
  end
end
