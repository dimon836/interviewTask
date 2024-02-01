# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ProjectsController do
  describe 'GET #index' do
    subject(:index_project_request) { get :index, format: :json }

    context 'when valid credentials' do
      include_context 'when valid credentials'

      let!(:projects) { create_list(:project, 3) }

      before { index_project_request }

      it 'returns http ok' do
        expect(response).to have_http_status(:ok)
      end

      it 'assigns projects' do
        expect(assigns(:projects)).to eq(projects)
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { index_project_request }
      end
    end
  end

  describe 'GET #show' do
    subject(:show_project_request) { get :show, params:, format: :json }

    let(:params) { { id: project.id } }
    let!(:project) { create(:project) }

    context 'when valid credentials' do
      include_context 'when valid credentials'

      context 'when success' do
        before { show_project_request }

        it 'returns http ok' do
          expect(response).to have_http_status(:ok)
        end

        it 'assigns project' do
          expect(assigns(:project)).to eq(project)
        end
      end

      context 'when errors' do
        let(:params) { { id: 0 } }

        before { show_project_request }

        it 'returns http unprocessable entity' do
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'has error json body' do
          expect(response.parsed_body['error']).to eq('Project not found for DESTROY.')
        end
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { show_project_request }
      end
    end
  end

  describe 'POST #create' do
    subject(:create_project_request) { post :create, params:, format: :json }

    let(:params) do
      {
        project: {
          name:,
          description: 'some description'
        }
      }
    end

    let(:name) { 'project name' }

    context 'when valid credentials' do
      include_context 'when valid credentials'

      let(:project_attributes) do
        assigns(:project).attributes.deep_symbolize_keys.except(:id, :created_at, :updated_at)
      end

      shared_examples 'project assigner' do
        before { create_project_request }

        it 'assigns project' do
          expect(project_attributes).to eq(params[:project])
        end
      end

      context 'when success' do
        it { is_expected.to have_http_status(:created) }

        it_behaves_like 'project assigner'
      end

      context 'when errors' do
        let(:name) { '' }

        it { is_expected.to have_http_status(:unprocessable_entity) }
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { create_project_request }
      end
    end
  end

  describe 'PUT #update' do
    subject(:update_project_request) { put :update, params:, format: :json }

    let(:params) do
      {
        id: project.id,
        project: {
          name:,
          description: 'some description'
        }
      }
    end

    let(:name) { 'project name' }
    let(:project) { create(:project) }

    context 'when valid credentials' do
      include_context 'when valid credentials'

      shared_examples 'project updater' do
        before { update_project_request }

        it 'assigns project' do
          expect(assigns(:project)).to eq(project.reload)
        end

        it 'has valid data' do
          expect(assigns(:project).attributes.deep_symbolize_keys.except(:id, :created_at,
                                                                         :updated_at)).to eq(params[:project])
        end
      end

      context 'when success' do
        it { is_expected.to have_http_status(:ok) }

        it_behaves_like 'project updater'
      end

      context 'when errors' do
        let(:name) { '' }

        it { is_expected.to have_http_status(:unprocessable_entity) }
      end
    end

    context 'when invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { update_project_request }
      end
    end
  end

  describe 'DELETE #destroy' do
    subject(:delete_project_request) { delete :destroy, params:, format: :json }

    let(:params) { { id: project.id } }
    let!(:project) { create(:project) }

    context 'with valid credentials' do
      include_context 'when valid credentials'

      context 'when success' do
        it { is_expected.to have_http_status(:ok) }
      end

      context 'when errors' do
        let(:params) { { id: 0 } }

        it { is_expected.to have_http_status(:unprocessable_entity) }
      end
    end

    context 'with invalid credentials' do
      it_behaves_like 'credentials checker' do
        before { delete_project_request }
      end
    end
  end
end
