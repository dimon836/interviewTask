# frozen_string_literal: true

RSpec.shared_examples 'do not presence fields' do
  it 'expects to have errors' do
    expect(service_method.errors.any?).to be true
  end

  it 'expects to have correct errors' do
    expect(service_method.errors.messages).to eq(errors)
  end

  it_behaves_like 'do not change model'
end
