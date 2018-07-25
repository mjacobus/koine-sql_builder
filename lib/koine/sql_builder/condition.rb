# frozen_string_literal: true

module Koine
  module SqlBuilder
    class Condition
      def to_s
        raise NotImplementedError
      end
    end
  end
end
