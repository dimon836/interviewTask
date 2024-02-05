# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    def create
      respond_to do |format|
        format.json do
          self.resource = warden.authenticate!(auth_options)
          sign_in(resource_name, resource)
          respond_with_authentication_token(resource)
        end
      end
    end

    protected

    def respond_with_authentication_token(resource)
      render json: { success: true, auth_token: resource.authentication_token, email: resource.email }
    end

    def set_flash_message(key, kind, options = {})
      # remove implementation
    end

    def require_no_authentication
      # remove implementation
    end
  end
end
