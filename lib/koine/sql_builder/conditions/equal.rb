# frozen_string_literal: true

module Koine
  module SqlBuilder
    module Conditions
      class Equal < Comparison
        def to_s
          if nil?
            return "#{field} IS NULL"
          end

          input = @adapter.to_input_value(value)

          "#{field} = #{input}"
        end
      end
    end
  end
end
