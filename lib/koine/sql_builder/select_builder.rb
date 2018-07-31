# frozen_string_literal: true

module Koine
  module SqlBuilder
    class SelectBuilder
      def initialize(from:, select:, where:, joins:, adapter:)
        @adapter = adapter.freeze
        @attributes = {
          select: select.freeze,
          from: from.freeze,
          joins: joins.freeze,
          where: where.freeze,
        }
        freeze
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

      def join(table_name, table_alias = nil)
        join = Join.new(table_name, table_alias, adapter: @adapter)

        create(:joins, @attributes[:joins].join(join))
      end

      def on(config)
        create(:joins, @attributes[:joins].on(config))
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
