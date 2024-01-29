# frozen_string_literal: true

module Projects
  class Destroy
    def self.call(project)
      new(project).call
    end

    def call
      remove
      self
    end

    attr_reader :project
    attr_accessor :errors

    private

    def initialize(project)
      @project = project
      @errors = {}
    end

    def remove
      return project.destroy if project.present?

      errors[:not_found] = 'Project not found for DESTROY.'
    end
  end
end
