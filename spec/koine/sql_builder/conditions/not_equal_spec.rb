# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::SqlBuilder::Conditions::NotEqual do
  let(:field) { 'name' }
  let(:value) { 'value' }
  let(:condition) { described_class.new(field, value, adapter: adapter).to_s }

  describe 'when value is nil' do
    let(:value) { nil }

    it 'handles uniquality properly' do
      expect(condition).to eq('name IS NOT NULL')
    end
  end

  describe 'when value is integer' do
    let(:value) { 1 }

    it 'handles uniquality properly' do
      expect(condition).to eq('name != 1')
    end
  end

  describe 'when value is a string' do
    let(:value) { 'bar' }

    it 'handles uniquality properly' do
      expect(condition).to eq('name != "bar"')
    end
  end
end
