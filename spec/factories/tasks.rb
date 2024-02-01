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
FactoryBot.define do
  factory :task do
    name { Faker::Name.name[3..30] }
    description { Faker::Lorem.sentence }

    project

    transient do
      status { Task.statuses.keys.first }
    end

    after(:build) do |task, evaluator|
      task.status = evaluator.status if evaluator.status.present?
    end

    trait :published do
      status { Task.statuses[:recent] }
    end

    trait :hidden do
      status { Task.statuses[:ongoing] }
    end

    trait :archived do
      status { Task.statuses[:completed] }
    end
  end
end
