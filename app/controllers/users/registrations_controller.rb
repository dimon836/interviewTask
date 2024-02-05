# frozen_string_literal: true

module Users
  class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters

    def create
      user = User.new(user_params)

      respond_to do |format|
        if user.save
          format.json { render json: user, status: :created }
        else
          format.json { render json: user.errors.full_messages, status: :unprocessable_entity }
        end
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: %i[email])
    end
  end
end
