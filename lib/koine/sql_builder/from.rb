# frozen_string_literal: true

module Koine
  module SqlBuilder
    class From
      def initialize(config = nil)
        if config.is_a?(Hash)
          config = config.map do |table, alias_name|
            "#{table} #{alias_name}"
          end.join(', ')
        end

        @as_string = config.to_s.freeze
        freeze
      end

      def to_s
        if present?
          return "FROM #{@as_string}"
        end

        ''
      end

      private

      def present?
        !@as_string.strip.empty?
      end
    end
  end
end
