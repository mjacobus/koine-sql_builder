# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::SqlBuilder::Adapter do
  let(:adapter) { subject }

  it 'has correct space as a #joiner' do
    expect(subject.joiner).to eq(' ')
  end

  describe '#quote' do
    it 'properly quotes a string' do
      result = adapter.quote('foo')

      expect(result).to eq('"foo"')
    end

    it 'properly quotes an integer' do
      result = adapter.quote(1)

      expect(result).to eq('1')
    end
  end

  describe '#build_conditions' do
    it 'build conditions as hash' do
      result = adapter.build_conditions(foo: 1, bar: :baz).map(&:to_s)

      expect(result).to eq(['foo = 1', 'bar = "baz"'])
    end
  end
end
