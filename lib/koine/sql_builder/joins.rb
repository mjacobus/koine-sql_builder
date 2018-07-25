# frozen_string_literal: true

module Koine
  module SqlBuilder
    class Joins
      Error = Class.new(StandardError)

      def initialize(items = [], adapter:)
        @items = items
        @adapter = adapter
      end

      def to_s
        items.map(&:to_s).join(' ')
      end

      def join(config)
        with_added_item(config)
      end

      def on(config)
        unless items.last.is_a?(Join)
          raise Error, 'ON can only be performed after a join'
        end

        join = JoinOn.new(config, adapter: adapter)
        with_added_item(join)
      end

      private

      attr_reader :items
      attr_reader :adapter

      def with_added_item(item)
        self.class.new([items, item].flatten, adapter: adapter)
      end
    end
  end
end
