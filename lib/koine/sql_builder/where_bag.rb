# frozen_string_literal: true

module Koine
  module SqlBuilder
    class WhereBag
      include Enumerable

      def initialize(conditions = [], adapter:)
        @adapter = adapter
        @conditions = adapter.build_conditions(Array(conditions).compact)
      end

      def each(&block)
        @conditions.each(&block)
      end

      def to_s
        unless conditions.empty?
          return "WHERE #{conditions.join(' AND ')}"
        end

        ''
      end

      private

      attr_reader :conditions
    end
  end
end
