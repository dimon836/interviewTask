# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::Create do
  subject(:task_create) { described_class.call(task_params) }

  let(:project) { create(:project) }

  let(:task_params) { { name:, description:, status:, project_id: project.id } }

  let(:name) { 'task name' }
  let(:description) { 'task description' }
  let(:status) { Task.statuses.keys.first }

  describe '#call' do
    context 'when success' do
      let(:task_attributes) do
        task_create.attributes.deep_symbolize_keys.except(:id, :created_at, :updated_at)
      end

      it { expect(task_attributes).to eq(task_params) }

      it_behaves_like 'creates a new object' do
        let(:model) { Task }
        let(:service_method) { task_create }
      end
    end

    context 'when errors' do
      context 'when validation errors' do
        it_behaves_like 'do not presence fields' do
          let(:model) { Task }
          let(:service_method) { task_create }

          let(:name) { '' }
          let(:description) { '' }
          let(:status) { nil }
          let(:errors) do
            {
              name: ["can't be blank", 'is too short (minimum is 3 characters)'],
              description: ["can't be blank"],
              status: ["can't be blank", 'is not included in the list']
            }
          end
        end
      end

      context 'when raises errors' do
        let(:status) { -1 }

        it 'expects to raise an ArgumentError error' do
          expect { task_create }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
