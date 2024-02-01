# frozen_string_literal: true

module ProjectsExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found_exception
  end

  private

  def handle_not_found_exception
    render json: { error: 'Project not found for DESTROY.' }, status: :unprocessable_entity
  end
end
