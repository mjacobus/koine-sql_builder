# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::SqlBuilder::SelectBuilder do
  subject(:builder) { Koine::SqlBuilder::Builder.new.select }

  describe '#from' do
    it 'can select from a table' do
      sql = immutable(builder) do |builder|
        builder.from('table')
      end

      expect(sql.to_s).to eq('SELECT * FROM table')
      expect(sql.from('other_table').to_s).to eq('SELECT * FROM other_table')
    end

    it 'can select with alias' do
      sql = immutable(builder) do |builder|
        builder.from('foobar' => 'fb')
      end

      expect(sql.to_s).to eq('SELECT * FROM foobar fb')
    end
  end

  describe '#select' do
    it 'selects fields as array' do
      sql = immutable(builder) do |builder|
        builder.select(%i[foo bar]).from('table_name')
      end.to_s

      expect(sql).to eq('SELECT foo, bar FROM table_name')
    end
  end

  describe '#where' do
    it 'returns SQL with conditions' do
      builder = subject.select(:foo).from(:bar)

      sql = immutable(builder) do |b|
        b.where(foo: :bar2, bar: 1)
      end.to_s

      expect(sql).to eq('SELECT foo FROM bar WHERE foo = "bar2" AND bar = 1')
    end
  end
end
