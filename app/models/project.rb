# frozen_string_literal: true

class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 30 }
end
