# frozen_string_literal: true

module Koine
  module SqlBuilder
    class Join
      def initialize(table_name, table_alias = nil, type: 'INNER', adapter:)
        @table_name = table_name
        @table_alias = table_alias || table_name
        @type = type
        @adapter = adapter
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
