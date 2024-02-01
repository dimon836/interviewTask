# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Projects::Destroy do
  subject(:project_destroy) { described_class.call(project) }

  let!(:project) { create(:project) }

  describe '#call' do
    context 'when success' do
      it 'has not any error' do
        expect(project_destroy.errors).to be_empty
      end

      it_behaves_like 'destroys an object' do
        let(:model) { Project }
        let(:service_method) { project_destroy }
      end
    end

    context 'when errors' do
      let(:project) { nil }

      let(:errors) { { not_found: 'Project not found for DESTROY.' } }

      it 'expects to have correct errors' do
        expect(project_destroy.errors).to eq(errors)
      end

      it_behaves_like 'do not change model' do
        let(:model) { Project }
        let(:service_method) { project_destroy }
      end
    end
  end
end
