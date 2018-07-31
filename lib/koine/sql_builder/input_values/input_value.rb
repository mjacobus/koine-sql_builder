# frozen_string_literal: true

module Koine
  module SqlBuilder
    module InputValues
      class InputValue
        def initialize(value, adapter:)
          @value = value.freeze
          @adapter = adapter.freeze
          freeze
        end

        def raw
          @value.to_s
        end

        def to_s
          @adapter.quote(raw)
        end

        def with_value(value)
          self.class.new(value, adapter: @adapter)
        end
      end
    end
  end
end
