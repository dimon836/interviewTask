# frozen_string_literal: true

module Tasks
  class Update
    def self.call(tasks, params)
      new(tasks, params).call
    end

    def call
      tasks.update(params)
      tasks
    end

    attr_reader :tasks, :params

    private

    def initialize(tasks, params)
      @tasks = tasks
      @params = params
    end
  end
end
