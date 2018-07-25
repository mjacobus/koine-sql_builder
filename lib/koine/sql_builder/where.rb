# frozen_string_literal: true

module Koine
  module SqlBuilder
    class Where
      include Enumerable

      def initialize(items = [], adapter:)
        @adapter = adapter
        @items = items
      end

      def with_added_conditions(items = {})
        items = Array(items).map do |item|
          @adapter.create_condition(item)
        end

        items = [@items, items].flatten
        self.class.new(items, adapter: @adapter)
      end

      def each(&block)
        @items.each(&block)
      end

      def to_s
        unless items.empty?
          return "WHERE #{to_a.join(' AND ')}"
        end

        ''
      end

      private

      attr_reader :items
    end
  end
end
