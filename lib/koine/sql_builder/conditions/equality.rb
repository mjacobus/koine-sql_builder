# frozen_string_literal: true

module Koine
  module SqlBuilder
    module Conditions
      class Equality < Condition
        def to_s
          if nil?
            return "#{field} IS NULL"
          end

          "#{field} = #{adapter.quote(value)}"
        end
      end
    end
  end
end
