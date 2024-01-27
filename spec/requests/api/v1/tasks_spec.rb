# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Tasks' do
  describe 'GET /index' do
    it 'returns http success' do
      get '/api/v1/tasks/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/api/v1/tasks/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    it 'returns http success' do
      get '/api/v1/tasks/create'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /update' do
    it 'returns http success' do
      get '/api/v1/tasks/update'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /destroy' do
    it 'returns http success' do
      get '/api/v1/tasks/destroy'
      expect(response).to have_http_status(:success)
    end
  end
end
