# frozen_string_literal: true

# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy

  # Запит для отримання проєкту з усіма його завданнями
  scope :with_tasks_by_project_id, ->(id) { includes(:tasks).where(id:).as_json(include: :tasks) }

  # Запит для отримання проєктів з усіма їх завданнями
  scope :with_tasks_by_project, -> { includes(:tasks).as_json(include: :tasks) }

  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
end
