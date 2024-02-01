# frozen_string_literal: true

# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  status      :integer
#  project_id  :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Task < ApplicationRecord
  belongs_to :project

  scope :project_tasks, ->(project_id) { where(project_id:) }

  # Запити для фільтрації завдань за статусом
  scope :by_status, ->(status) { where(status:) }
  scope :by_status_asc, -> { order(status: :asc) }
  scope :by_status_desc, -> { order(status: :desc) }

  enum status: {
    recent: 1,
    ongoing: 2,
    completed: 3
  }

  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
  validates :description, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }
end
