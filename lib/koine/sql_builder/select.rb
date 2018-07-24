# frozen_string_literal: true

module Koine
  module SqlBuilder
    class Select
      def initialize(*args)
        config = args.flatten.inject([]) do |sum, item|
          if item.is_a?(Hash)
            item = item.map { |k, v| "#{k} AS #{v}" }
          end

          [sum, item].flatten
        end

        if config.empty?
          config = ['*']
        end

        @as_string = config.join(', ').to_s
      end

      def to_s
        "SELECT #{@as_string}"
      end
    end
  end
end
