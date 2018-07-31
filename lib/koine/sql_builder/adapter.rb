# frozen_string_literal: true

module Koine
  module SqlBuilder
    class Adapter
      ArgumentError = Class.new(::ArgumentError)

      INTEGER_REGEXP = /^\d+$/

      attr_reader :joiner

      def initialize(joiner: "\s")
        @joiner = joiner.freeze
        freeze
      end

      def create_condition(item)
        if item.is_a?(Array)
          return condition_from_array(item)
        end

        if item.is_a?(Condition)
          return item
        end

        raise ArgumentError, "Unrecognized condition #{item.inspect}"
      end

      def equal(field, value)
        Conditions::Equal.new(field, value, adapter: self)
      end

      def to_input_value(value)
        klass = Koine::SqlBuilder::InputValues::InputValue

        if value.is_a?(klass)
          return value
        end

        klass.new(value, adapter: self)
      end

      def to_literal(value)
        Koine::SqlBuilder::InputValues::Literal.new(value, adapter: self)
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
