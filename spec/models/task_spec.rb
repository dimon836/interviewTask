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
require 'rails_helper'

RSpec.describe Task do
  subject(:task) { create(:task) }

  describe 'validations' do
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:name) }

    it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(30) }

    it { is_expected.to validate_presence_of(:description) }

    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:project) }
  end

  describe 'indexes' do
    it { is_expected.to have_db_index(:project_id) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:status).with_values(recent: 1, ongoing: 2, completed: 3) }
  end
end
