# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Projects::Create do
  subject(:project_create) { described_class.call(project_params) }

  let(:project_params) { { name:, description: } }

  let(:name) { 'name' }
  let(:description) { 'some project description' }

  describe '#call' do
    context 'when success' do
      let(:project_attributes) do
        project_create.attributes.deep_symbolize_keys.except(:id, :created_at, :updated_at)
      end

      it { expect(project_attributes).to eq(project_params) }

      it_behaves_like 'creates a new object' do
        let(:model) { Project }
        let(:service_method) { project_create }
      end
    end

    context 'when validation errors' do
      context 'when name is too short' do
        let(:name) { 's' }
        let(:errors) { { name: ['is too short (minimum is 3 characters)'] } }

        it 'expects error when name short' do
          expect(project_create.errors.any?).to be true
        end

        it 'expects to have correct errors' do
          expect(project_create.errors.messages).to eq(errors)
        end

        it_behaves_like 'do not change model' do
          let(:model) { Project }
          let(:service_method) { project_create }
        end
      end

      it_behaves_like 'do not presence fields' do
        let(:model) { Project }
        let(:service_method) { project_create }

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
