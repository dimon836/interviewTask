# frozen_string_literal: true

RSpec.shared_examples 'creates a new object' do
  it 'increases model count by 1' do
    expect { service_method }.to change(model, :count).by(1)
  end
end

RSpec.shared_examples 'destroys an object' do
  it 'decreases model count by 1' do
    expect { service_method }.to change(model, :count).by(-1)
  end
end

RSpec.shared_examples 'do not change model' do
  it 'does not change model count' do
    expect { service_method }.not_to change(model, :count)
  end
end
