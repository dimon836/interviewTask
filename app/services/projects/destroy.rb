# frozen_string_literal: true

module Projects
  class Destroy
    def self.call(project_id)
      new(project_id).call
    end

    def call
      remove
      self
    end

    attr_reader :project_id
    attr_accessor :errors

    private

    def initialize(project_id)
      @project_id = project_id
      @errors = {}
    end

    def project
      @project ||= Project.find(project_id)
    end

    def remove
      return project.destroy if project.present?

      errors[:not_found] = 'Project not found for DESTROY.'
    end
  end
end
