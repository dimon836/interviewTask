# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :project

  scope :project_tasks, ->(project_id) { where(project_id:) }

  enum status: {
    recent: 1,
    ongoing: 2,
    completed: 3
  }

  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :status, presence: true, inclusion: { in: statuses.keys }
end
