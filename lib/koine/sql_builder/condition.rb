# frozen_string_literal: true

module Koine
  module SqlBuilder
    class Condition
      def initialize(field, value, adapter:)
        @adapter = adapter
        @field = field.dup
        @value = value.dup
      end

      def to_s
        raise 'not implemented'
      end

      private

      attr_reader :field
      attr_reader :value
      attr_reader :adapter

      def nil?
        @value.nil?
      end
    end
  end
end
