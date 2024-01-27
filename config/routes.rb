# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'tasks/index'
      get 'tasks/show'
      get 'tasks/create'
      get 'tasks/update'
      get 'tasks/destroy'

      get 'projects/index'
      get 'projects/show'
      get 'projects/create'
      get 'projects/update'
      get 'projects/destroy'
    end
  end
end
