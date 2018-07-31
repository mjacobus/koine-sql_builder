# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::SqlBuilder::Conditions::Comparison do
  subject do
    described_class.new(:field, :value, adapter: adapter)
  end

  it 'is a Condition' do
    expect(subject).to be_a(Koine::SqlBuilder::Condition)
  end

  it 'raises an error when #to_s is called' do
    expect { subject.to_s }.to raise_error(NotImplementedError)
  end

  describe '#not' do
    let(:comparison) do
      Koine::SqlBuilder::Conditions::Equal.new(:foo, :bar, adapter: adapter)
    end

    let(:not_comparison) do
      Koine::SqlBuilder::Conditions::NotEqual.new(:foo, :bar, adapter: adapter)
    end

    describe 'when it is comparison' do
      it 'returns the Not version' do
        expect(comparison.not).to be_equal_to(not_comparison)
      end
    end

    describe 'when it is not_comparison' do
      it 'returns the Not version' do
        expect(not_comparison.not).to be_equal_to(comparison)
      end
    end

    describe 'when class negation does not exist' do
      let(:comparison) do
        klass = Class.new(Koine::SqlBuilder::Conditions::Equal) do
          def class
            'Foo'
          end
        end

        klass.new(:foo, :bar, adapter: adapter)
      end

      it 'raises error' do
        expect { comparison.not }.to raise_error(
          NotImplementedError,
          'Comparison class NotFoo is not defined'
        )
      end
    end
  end
end
