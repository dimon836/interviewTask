# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :project

  enum status: {
    new: 1,
    in_progress: 2,
    finished: 3
  }

  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :status, presence: true, inclusion: { in: statuses.keys }
end
