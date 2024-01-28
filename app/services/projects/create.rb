# frozen_string_literal: true

module Projects
  class Create
    def self.call(params)
      new(params).call
    end

    def call
      Project.create(params)
    end

    attr_reader :params

    private

    def initialize(params)
      @params = params
    end
  end
end
