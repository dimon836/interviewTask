# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation, except: %w[ar_internal_metadata]
  end

  config.before do
    DatabaseCleaner.strategy = :transaction
  end

  config.before do
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  rescue NoMethodError => e
    if e.message == %(undefined method `rollback' for nil:NilClass (DB Cleaner gem))
      next puts("Warning: catch #{e.message}")
    end

    raise e
  end
end
