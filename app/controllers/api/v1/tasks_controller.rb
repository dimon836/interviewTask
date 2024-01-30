# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :task, only: %i[show update destroy]

      def index
        @tasks = Task.by_status(Task.statuses[:recent])

        respond_to do |format|
          format_response(format, @tasks, :ok)
        end
      end

      def show
        respond_to do |format|
          if @task
            format_response(format, @task, :ok)
          else
            format_response(format, { error: 'Task not found' }, :unprocessable_entity)
          end
        end
      end

      def create
        @task = Tasks::Create.call(task_params)

        respond_to do |format|
          if @task.errors.any?
            format_response(format, { error: 'Error creating task' }, :unprocessable_entity)
          else
            format_response(format, @task, :created)
          end
        end
      end

      def update
        @task = Tasks::Update.call(@task, task_params)

        respond_to do |format|
          if @task.errors.any?
            format_response(format, { error: 'Error updating task' }, :unprocessable_entity)
          else
            format_response(format, @task, :ok)
          end
        end
      end

      def destroy
        @destroyed_task = Tasks::Destroy.call(@task)

        respond_to do |format|
          if @destroyed_task.errors.present?
            format_response(format, { error: @destroyed_task.errors[:not_found] }, :unprocessable_entity)
          else
            format_response(format, { success: 'Task destroyed' }, :ok)
          end
        end
      end

      private

      def task_params
        params.require(:task).permit(:name, :description, :status).merge(project_id: params[:project_id])
      end

      def task
        @task ||= Task.find(params[:id])
      end

      def format_response(format, render_json, status)
        format.json { render json: render_json, status: }
      end
    end
  end
end
