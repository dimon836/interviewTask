# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tasks::Destroy do
  subject(:task_destroy) { described_class.call(task) }

  let(:project) { create(:project) }

  let!(:task) { create(:task, project:) }

  describe '#call' do
    context 'when success' do
      it 'has not any error' do
        expect(task_destroy.errors).to be_empty
      end

      it_behaves_like 'destroys an object' do
        let(:model) { Task }
        let(:service_method) { task_destroy }
      end
    end

    context 'when errors' do
      let(:task) { nil }

      let(:errors) { { not_found: 'Task not found for DESTROY.' } }

      it 'expects to have correct errors' do
        expect(task_destroy.errors).to eq(errors)
      end

      it_behaves_like 'do not change model' do
        let(:model) { Task }
        let(:service_method) { task_destroy }
      end
    end
  end
end
