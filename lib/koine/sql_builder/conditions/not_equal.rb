# frozen_string_literal: true

module Koine
  module SqlBuilder
    module Conditions
      class NotEqual < Comparison
        def to_s
          if nil?
            return "#{field} IS NOT NULL"
          end

          "#{field} != #{adapter.quote(value)}"
        end
      end
    end
  end
end
