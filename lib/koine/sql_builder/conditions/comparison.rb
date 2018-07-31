# frozen_string_literal: true

module Koine
  module SqlBuilder
    module Conditions
      class Comparison < Condition
        def initialize(field, value, adapter:)
          @adapter = adapter.freeze
          @field = field.dup.freeze
          @value = value.dup.freeze
          freeze
        end

        def not
          not_class.new(field, value, adapter: adapter)
        end

        private

        attr_reader :field
        attr_reader :value
        attr_reader :adapter

        def nil?
          @value.nil?
        end

        def not_class
          parts = self.class.to_s.split('::')
          last = parts.pop
          last = "Not#{last}".sub('NotNot', '')
          klass = parts.push(last).join('::')

          if Object.const_defined?(klass)
            return Object.const_get(klass)
          end

          raise NotImplementedError, "Comparison class #{klass} is not defined"
        end
      end
    end
  end
end
