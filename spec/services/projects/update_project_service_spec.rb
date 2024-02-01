# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Projects::Update do
  subject(:project_update) { described_class.call(project, project_params) }

  let(:project_params) { { name:, description: } }

  let(:name) { 'name' }
  let(:description) { 'project description' }

  let!(:project) { create(:project) }

  describe '#call' do
    context 'when success' do
      let(:project_attributes) do
        project_update.attributes.deep_symbolize_keys.except(:id, :created_at, :updated_at)
      end

      it 'has valid data' do
        expect(project_attributes).to eq(project_params)
      end

      it { is_expected.to eq(project.reload) }

      it_behaves_like 'do not change model' do
        let(:model) { Project }
        let(:service_method) { project_update }
      end
    end

    context 'when validation errors' do
      it_behaves_like 'do not presence fields' do
        let(:model) { Project }
        let(:service_method) { project_update }

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
