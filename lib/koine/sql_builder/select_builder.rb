# frozen_string_literal: true

module Koine
  module SqlBuilder
    class SelectBuilder
      def initialize(from:, select:, where:, adapter:)
        @adapter = adapter
        @attributes = {
          select: select,
          from: from,
          where: where,
        }
      end

      def select(select = nil)
        create(:select, Select.new(select))
      end

      def from(from)
        create(:from, From.new(from))
      end

      def where(conditions = {})
        create(:where, @attributes[:where].with_added_conditions(conditions))
      end

      def to_s
        @attributes.values.map(&:to_s).map(&:strip).reject do |element|
          element == ''
        end.join(@adapter.joiner)
      end

      private

      def create(attribute, value)
        self.class.new(@attributes.merge(attribute => value, adapter: @adapter))
      end
    end
  end
end
