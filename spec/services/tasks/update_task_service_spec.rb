# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::Update do
  subject(:task_update) { described_class.call(task, task_params) }

  let(:project) { create(:project) }

  let(:task_params) { { name:, description:, status: Task.statuses.keys.second, project_id: project.id } }

  let(:name) { 'Peter' }
  let(:description) { 'some task description' }

  let!(:task) { create(:task, project:) }

  describe '#call' do
    context 'when success' do
      let(:task_attributes) do
        task_update.attributes.deep_symbolize_keys.except(:id, :created_at, :updated_at)
      end

      it 'has valid data' do
        expect(task_attributes).to eq(task_params)
      end

      it { is_expected.to eq(task.reload) }

      it_behaves_like 'do not change model' do
        let(:model) { Task }
        let(:service_method) { task_update }
      end
    end

    context 'when validation errors' do
      it_behaves_like 'do not presence fields' do
        let(:model) { Task }
        let(:service_method) { task_update }

        let(:name) { '' }
        let(:description) { '' }
        let(:errors) do
          {
            name: ["can't be blank", 'is too short (minimum is 3 characters)'],
            description: ["can't be blank"]
          }
        end
      end
    end
  end
end
