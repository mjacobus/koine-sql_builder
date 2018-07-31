# frozen_string_literal: true

module Koine
  module SqlBuilder
    module InputValues
      class Literal < InputValue
        def to_s
          raw
        end
      end
    end
  end
end
