# frozen_string_literal: true

module Tasks
  class Destroy
    def self.call(task)
      new(task).call
    end

    def call
      remove
      self
    end

    attr_reader :task
    attr_accessor :errors

    private

    def initialize(task)
      @task = task
      @errors = {}
    end

    def remove
      return task.destroy if task.present?

      errors[:not_found] = 'Task not found for DESTROY.'
    end
  end
end
