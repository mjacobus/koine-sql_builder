# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::SqlBuilder::Adapter do
  let(:adapter) { subject }
  let(:sample_condition) do
    Koine::SqlBuilder::Conditions::Equality.new(:foo, :bar, adapter: adapter)
  end

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

  describe '#equal' do
    it 'returns an equality condition' do
      condition = adapter.equal(:foo, :bar)

      expect(condition).to be_equal_to(sample_condition)
    end
  end

  describe '#create_condition' do
    it 'deals with equality condition' do
      condition = adapter.create_condition(%i[foo bar])

      expect(condition).to be_equal_to(sample_condition)
    end

    it 'raises when condition is unknown' do
      expect do
        adapter.create_condition(%i[foo bar baz])
      end.to raise_error(
        Koine::SqlBuilder::Adapter::ArgumentError,
        'Invalid argument'
      )
    end

    it 'deals with condition' do
      condition = adapter.create_condition(sample_condition)

      expect(condition).to be(sample_condition)
    end
  end
end
