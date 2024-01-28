# frozen_string_literal: true

module Projects
  class Update
    def self.call(project, params)
      new(project, params).call
    end

    def call
      project.update(params)
      project
    end

    attr_reader :project, :params

    private

    def initialize(project, params)
      @project = project
      @params = params
    end
  end
end
