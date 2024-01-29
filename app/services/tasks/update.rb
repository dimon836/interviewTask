# frozen_string_literal: true

module Tasks
  class Update
    def self.call(task, params)
      new(task, params).call
    end

    def call
      task.update(params)
      task
    end

    attr_reader :task, :params

    private

    def initialize(task, params)
      @task = task
      @params = params
    end
  end
end
