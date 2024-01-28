# frozen_string_literal: true

module Tasks
  class Destroy
    def self.call(task_id)
      new(task_id).call
    end

    def call
      remove
      self
    end

    attr_reader :task_id
    attr_accessor :errors

    private

    def initialize(task_id)
      @task_id = task_id
      @errors = {}
    end

    def task
      @task ||= Task.find(task_id)
    end

    def remove
      return task.destroy if task.present?

      errors[:not_found] = 'Task not found for DESTROY.'
    end
  end
end
