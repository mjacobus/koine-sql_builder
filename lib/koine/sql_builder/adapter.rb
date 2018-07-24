# frozen_string_literal: true

module Koine
  module SqlBuilder
    class Adapter
      INTEGER_REGEXP = /^\d+$/

      def joiner
        "\s"
      end

      def build_conditions(conditions)
        conditions.map do |key, value|
          equal(key, value)
        end
      end

      def equal(key, value)
        "#{key} = #{quote(value)}"
      end

      def quote(value)
        if INTEGER_REGEXP.match?(value.to_s)
          return value.to_s
        end

        "\"#{value}\""
      end
    end
  end
end
