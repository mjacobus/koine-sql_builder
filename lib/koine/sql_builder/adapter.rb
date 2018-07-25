# frozen_string_literal: true

module Koine
  module SqlBuilder
    class Adapter
      ArgumentError = Class.new(::ArgumentError)

      INTEGER_REGEXP = /^\d+$/

      def joiner
        "\s"
      end

      def build_conditions(conditions)
        conditions.map do |key, value|
          equal(key, value)
        end
      end

      def create_condition(item)
        if item.is_a?(Array)
          return condition_from_array(item)
        end

        if item.is_a?(Condition)
          return item
        end

        raise "oops #{item.class}"
      end

      def equal(field, value)
        Conditions::Equality.new(field, value, adapter: self)
      end

      def quote(value)
        if INTEGER_REGEXP.match?(value.to_s)
          return value.to_s
        end

        "\"#{value}\""
      end

      private

      def condition_from_array(array)
        if array.length != 2
          raise ArgumentError, 'Invalid argument'
        end

        equal(array.first, array.last)
      end
    end
  end
end
