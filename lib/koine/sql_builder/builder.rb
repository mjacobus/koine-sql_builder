# frozen_string_literal: true

module Koine
  module SqlBuilder
    class Builder
      def select(*args)
        SelectBuilder.new(
          adapter: adapter,
          select: Select.new(*args),
          from: From.new,
          where: WhereBag.new(adapter: adapter)
        )
      end

      private

      def adapter
        @adapter ||= Adapter.new
      end
    end
  end
end
