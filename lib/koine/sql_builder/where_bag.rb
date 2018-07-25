# frozen_string_literal: true

module Koine
  module SqlBuilder
    class WhereBag
      include Enumerable

      def initialize(conditions = [], adapter:)
        @adapter = adapter
        @conditions = conditions
      end

      def with_added_conditions(conditions = {})
        conditions = Array(conditions).map do |condition|
          @adapter.create_condition(condition)
        end

        conditions = [@conditions, conditions].flatten
        self.class.new(conditions, adapter: @adapter)
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
