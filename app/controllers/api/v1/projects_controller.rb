# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      include ProjectsExceptionHandler

      before_action :project, only: %i[show update destroy]

      def index
        @projects = Project.all

        respond_to do |format|
          format_response(format, @projects, :ok)
        end
      end

      def show
        respond_to do |format|
          if project
            format_response(format, @project, :ok)
          else
            format_response(format, { error: 'Project not found' }, :unprocessable_entity)
          end
        end
      end

      def create
        @project = Projects::Create.call(project_params)

        respond_to do |format|
          if @project.errors.any?
            format_response(format, { error: 'Error creating project' }, :unprocessable_entity)
          else
            format_response(format, @project, :created)
          end
        end
      end

      def update
        @is_updated_project = Projects::Update.call(project, project_params)

        respond_to do |format|
          if @is_updated_project.errors.any?
            format_response(format, { error: 'Error updating project' }, :unprocessable_entity)
          else
            format_response(format, @is_updated_project, :ok)
          end
        end
      end

      def destroy
        @destroyed_project = Projects::Destroy.call(project)

        respond_to do |format|
          if @destroyed_project.errors.present?
            format_response(format, { error: @destroyed_project.errors[:not_found] }, :unprocessable_entity)
          else
            format_response(format, { success: 'Project destroyed' }, :ok)
          end
        end
      end

      private

      def project_params
        params.require(:project).permit(:name, :description)
      end

      def project
        @project ||= Project.find(params[:id])
      end

      def format_response(format, render_json, status)
        format.json { render json: render_json, status: }
      end
    end
  end
end
