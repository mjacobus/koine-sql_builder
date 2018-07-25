# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::SqlBuilder::Where do
  let(:adapter) { Koine::SqlBuilder::Adapter.new }

  subject(:bag) { described_class.new([], adapter: adapter) }

  describe '#with_added_conditions' do
    it 'adds the conditions' do
      conditions = immutable(bag) do |bag|
        bag.with_added_conditions(foo: :bar)
      end

      conditions2 = immutable(conditions) do |bag|
        bag.with_added_conditions(bar: 1)
      end

      expect(conditions.to_s).to eq('WHERE foo = "bar"')
      expect(conditions2.to_s).to eq('WHERE foo = "bar" AND bar = 1')
    end
  end
end
