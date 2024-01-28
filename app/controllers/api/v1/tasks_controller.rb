# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController

      def show
        @task = Task.new
      end

      def create
        @task = Task::Create.call(task_params)

        respond_to do |format|
          if @task.errors.any?
            format.json { render json: { error: 'Error creating task' }, status: :unprocessable_entity }
          else
            format.json { render json: @task, status: :created }
          end
        end
      end

      def update
        @task = Task::Update.call(@task, task_params)

        respond_to do |format|
          if @task.errors.any?
            format.json { render json: { error: 'Error updating task' }, status: :unprocessable_entity }
          else
            format.json { render json: @task, status: :ok }
          end
        end
      end

      def destroy
        @destroyed_task = Task::Destroy.call(params[:id])

        respond_to do |format|
          if @destroyed_task.errors.present?
            format.json { render json: { error: @destroyed_task.errors[:not_found] }, status: :unprocessable_entity }
          else
            format.json { render json: { success: 'Task destroyed' }, status: :ok }
          end
        end
      end

      private

      def task_params
        params.require(:task).permit(:name, :description, :status).merge(project_id: params[:project_id])
      end
    end
  end
end
