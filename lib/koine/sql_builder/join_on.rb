# frozen_string_literal: true

module Koine
  module SqlBuilder
    class JoinOn
      def initialize(on, adapter:)
        @on = on
        @adapter = adapter
      end

      def to_s
        "ON #{@on}"
      end
    end
  end
end
