# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::SqlBuilder::InputValues::InputValue do
  subject(:input_value) { described_class.new('foo', adapter: adapter) }

  describe '#raw' do
    it 'returns the raw value as string' do
      expect(input_value.raw).to eq('foo')
    end
  end

  describe '#to_s' do
    it 'returns the quoted value' do
      expect(input_value.to_s).to eq('"foo"')
    end

    it 'returns the quoted value' do
      value = immutable(input_value) do |obj|
        obj.with_value(1)
      end

      expect(value.to_s).to eq('1')
    end
  end

  describe '#with_value' do
    it 'returns a new instance of the object with the modified object' do
      new_value = immutable(input_value) do |obj|
        obj.with_value(1)
      end

      expected = described_class.new(1, adapter: adapter)

      expect(new_value).to be_equal_to(expected)
    end
  end
end
