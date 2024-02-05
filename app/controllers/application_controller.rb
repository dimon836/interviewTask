# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::RequestForgeryProtection


  protect_from_forgery with: :null_session, if: :json_request?

  before_action :authenticate_user!

  acts_as_token_authentication_handler_for User

  private

  def json_request?
    request.format == :json
  end
end
