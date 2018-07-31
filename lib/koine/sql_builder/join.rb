# frozen_string_literal: true

module Koine
  module SqlBuilder
    class Join
      def initialize(table_name, table_alias = nil, type: 'INNER', adapter:)
        @table_name = table_name.freeze
        @table_alias = (table_alias || table_name).freeze
        @type = type.freeze
        @adapter = adapter.freeze
        freeze
      end

      def to_s
        if @table_name == @table_alias
          return "#{@type} JOIN #{@table_name}"
        end

        "#{@type} JOIN #{@table_name} #{@table_alias}"
      end
    end
  end
end
