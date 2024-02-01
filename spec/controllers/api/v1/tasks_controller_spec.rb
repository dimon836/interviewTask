# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TasksController do
  let(:project) { create(:project) }

  describe 'GET #index' do
    subject(:index_task_request) { get :index, params: { project_id: project.id }, format: :json }

    context 'when valid credentials' do
      include_context 'when valid credentials'

      let!(:tasks) { create_list(:task, 3, project:) }

      before { index_task_request }

      it 'returns http ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns projects' do
        expect(assigns(:tasks)).to eq(tasks)
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { index_task_request }
      end
    end
  end

  describe 'GET #show' do
    subject(:show_task_request) { get :show, params:, format: :json }

    let(:params) do
      {
        id:,
        project_id: project.id
      }
    end

    let(:id) { task.id }

    let!(:task) { create(:task) }

    context 'when valid credentials' do
      include_context 'when valid credentials'

      context 'when success' do
        before { show_task_request }

        it 'returns http ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'assigns project' do
          expect(assigns(:task)).to eq(task)
        end
      end

      context 'when errors' do
        let(:id) { 0 }

        before { show_task_request }

        it 'returns http unprocessable entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'has error json body' do
          expect(response.parsed_body['error']).to eq('Task not found for DESTROY.')
        end
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { show_task_request }
      end
    end
  end

  describe 'POST #create' do
    subject(:create_task_request) { post :create, params:, format: :json }

    let(:params) do
      {
        task: {
          name: 'task name',
          description:,
          status: Task.statuses.keys.first
        },
        project_id: project.id
      }
    end

    let(:description) { 'task description' }

    context 'when valid credentials' do
      include_context 'when valid credentials'

      let(:task_attributes) do
        assigns(:task).attributes.deep_symbolize_keys.except(:id, :created_at, :updated_at)
      end

      shared_examples 'task assigner' do
        before { create_task_request }

        it 'assigns task' do
          expect(task_attributes).to eq(params[:task].merge(project_id: params[:project_id]))
        end
      end

      context 'when success' do
        it { is_expected.to have_http_status(:created) }

        it_behaves_like 'task assigner'
      end

      context 'when errors' do
        let(:description) { '' }

        it { is_expected.to have_http_status(:unprocessable_entity) }

        it_behaves_like 'task assigner'
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { create_task_request }
      end
    end
  end

  describe 'PUT #update' do
    subject(:update_task_request) { put :update, params:, format: :json }

    let(:params) do
      {
        id: task.id,
        task: {
          name: 'task name',
          description:,
          status: Task.statuses.keys.first
        },
        project_id: project.id
      }
    end

    let(:description) { 'task description' }

    let!(:task) { create(:task, project:) }

    context 'when valid credentials' do
      include_context 'when valid credentials'

      context 'when success' do
        before { update_task_request }

        it 'returns http ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'assigns task' do
          expect(assigns(:task)).to eq(task.reload)
        end

        it 'has valid data' do
          expect(assigns(:task).attributes.deep_symbolize_keys
                               .except(:id, :created_at, :updated_at, :project_id)).to eq(params[:task])
        end
      end

      context 'when errors' do
        let(:description) { '' }

        it { is_expected.to have_http_status(:unprocessable_entity) }
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { update_task_request }
      end
    end
  end

  describe 'DELETE #destroy' do
    subject(:delete_task_request) { delete :destroy, params:, format: :json }

    let(:params) do
      {
        id:,
        project_id: project.id
      }
    end

    let(:id) { task.id }

    let!(:task) { create(:task, project:) }

    context 'with valid credentials' do
      include_context 'when valid credentials'

      context 'when success' do
        it { is_expected.to have_http_status(:ok) }
      end

      context 'when errors' do
        let(:id) { 0 }

        context 'when deletes in before' do
          it { is_expected.to have_http_status(:unprocessable_entity) }
        end
      end
    end

    context 'with invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { delete_task_request }
      end
    end
  end
end
