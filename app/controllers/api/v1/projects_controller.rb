# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      def show
        @project = Project.find(params[:id])

        respond_to do |format|
          if @project
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
        @project = Project::Update.call(@project, project_params)

        respond_to do |format|
          if @project.errors.any?
            format_response(format, { error: 'Error updating project' }, :unprocessable_entity)
          else
            format_response(format, @project, :ok)
          end
        end
      end

      def destroy
        @destroyed_project = Project::Destroy.call(params[:id])

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

      def format_response(format, render_json, status)
        format.json { render json: render_json, status: }
      end
    end
  end
end
