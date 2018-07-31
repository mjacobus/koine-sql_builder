# frozen_string_literal: true

module Koine
  module SqlBuilder
    class Builder
      attr_reader :adapter

      def initialize(adapter: Adapter.new)
        @adapter = adapter.freeze
        freeze
      end

      def select(*args)
        SelectBuilder.new(
          adapter: adapter,
          select: Select.new(*args),
          from: From.new,
          joins: Joins.new(adapter: adapter),
          where: Where.new(adapter: adapter)
        )
      end
    end
  end
end
