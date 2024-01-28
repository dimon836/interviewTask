# frozen_string_literal: true

class ApplicationController < ActionController::API
  http_basic_authenticate_with name: 'dhh', password: 'secret'
end
