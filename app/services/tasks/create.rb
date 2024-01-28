# frozen_string_literal: true

module Tasks
  class Create
    def self.call(params)
      new(params).call
    end

    def call
      Task.create(params)
    end

    attr_reader :params

    private

    def initialize(params)
      @params = params
    end
  end
end
