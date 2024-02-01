# frozen_string_literal: true

RSpec.shared_examples 'credentials checker' do
  let(:invalid_credentials) { ActionController::HttpAuthentication::Basic.encode_credentials('user', 'pass') }

  before { request.headers['Authorization'] = invalid_credentials }

  it 'returns 401 Unauthorized status' do
    expect(response).to have_http_status(:unauthorized)
  end
end
