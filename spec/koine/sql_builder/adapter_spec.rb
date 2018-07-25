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

    it 'raises when type of item is not recognized' do
      expect do
        adapter.create_condition('string')
      end.to raise_error(
        Koine::SqlBuilder::Adapter::ArgumentError,
        'Unrecognized condition "string"'
      )
    end

    it 'deals with formatted Condition' do
      condition = adapter.create_condition(sample_condition)

      expect(condition).to be(sample_condition)
    end
  end
end
