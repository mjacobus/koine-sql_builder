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
end
