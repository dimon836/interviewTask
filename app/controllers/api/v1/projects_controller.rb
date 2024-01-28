# frozen_string_literal: true

module Api
  module V1
    class ProjectsController < ApplicationController
      def index
        Project.all
      end

      def show
        @project = Project.new
      end

      def create
        @project = Projects::Create.call(project_params)

        respond_to do |format|
          if @project.errors.any?
            format.json { render json: { error: 'Error creating project' }, status: :unprocessable_entity }
          else
            format.json { render json: @project, status: :created }
          end
        end
      end

      def update
        @project = Project::Update.call(@project, project_params)

        respond_to do |format|
          if @project.errors.any?
            format.json { render json: { error: 'Error updating project' }, status: :unprocessable_entity }
          else
            format.json { render json: @project, status: :ok }
          end
        end
      end

      def destroy
        @destroyed_project = Project::Destroy.call(params[:id])

        respond_to do |format|
          if @destroyed_project.errors.present?
            format.json { render json: { error: @destroyed_project.errors[:not_found] }, status: :unprocessable_entity }
          else
            format.json { render json: { success: 'Project destroyed' }, status: :ok }
          end
        end
      end

      private

      def project_params
        params.require(:project).permit(:name, :description)
      end
    end
  end
end
