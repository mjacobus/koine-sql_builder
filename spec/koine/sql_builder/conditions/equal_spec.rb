# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::SqlBuilder::Conditions::Equal do
  let(:field) { 'name' }
  let(:value) { 'value' }
  let(:condition) { described_class.new(field, value, adapter: adapter).to_s }

  describe 'when value is nil' do
    let(:value) { nil }

    it 'handles equality properly' do
      expect(condition).to eq('name IS NULL')
    end
  end

  describe 'when value is nil' do
    let(:value) { nil }

    it 'handles equality properly' do
      expect(condition).to eq('name IS NULL')
    end
  end

  describe 'when value is integer' do
    let(:value) { 1 }

    it 'handles equality properly' do
      expect(condition).to eq('name = 1')
    end
  end

  describe 'when value is a string' do
    let(:value) { 'bar' }

    it 'handles equality properly' do
      expect(condition).to eq('name = "bar"')
    end
  end
end
