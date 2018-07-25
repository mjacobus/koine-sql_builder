# frozen_string_literal: true

require 'bundler/setup'
require 'koine/sql_builder'

class Examples
  include Enumerable

  def initialize
    adapter = Koine::SqlBuilder::Adapter.new(joiner: "\n")
    @builder = Koine::SqlBuilder::Builder.new(adapter: adapter)
    @examples = []
  end

  def add
    @examples.push(yield(@builder))
  end

  def each(&block)
    @examples.each(&block)
  end
end
