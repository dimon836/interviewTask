# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController

      def show; end

      def create; end

      def update; end

      def destroy; end
    end

    private

    def project_params
      params.require(:project).permit(:name, :description, :status).merge(project_id: params[:project_id])
    end
  end
end
