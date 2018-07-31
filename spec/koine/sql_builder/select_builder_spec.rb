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

    it 'returns SQL with as condition classes' do
      builder = subject.select(:foo).from(:bar)

      sql = immutable(builder) do |b|
        b.where(adapter.equal(:foo, nil).not)
      end.to_s

      expect(sql).to eq('SELECT foo FROM bar WHERE foo IS NOT NULL')
    end

    it 'takes literal' do
      value = adapter.to_literal(':value')

      query = builder
        .select("*")
        .from(:users)
        .where(user_id: value)

      expected = 'SELECT * FROM users WHERE user_id = :value'

      expect(query.to_s).to eq(expected)
    end
  end

  # join(:users, :u).on(u: :id, other: :user_id)
  describe '#join' do
    let(:query) { builder.from(:foo) }

    it 'joins table' do
      sql = immutable(query) do
        query.join(:articles)
      end

      expect(sql.to_s).to eq('SELECT * FROM foo INNER JOIN articles')
    end

    it 'joins table with alias' do
      sql = immutable(query) do
        query.join(:articles, :a)
      end

      expect(sql.to_s).to eq('SELECT * FROM foo INNER JOIN articles a')
    end

    it 'joins table with ON' do
      sql = immutable(query) do
        query.join(:articles, :a).on('foo = bar').where(one: 1)
      end

      expect(sql.to_s).to eq('SELECT * FROM foo INNER JOIN articles a ON foo = bar WHERE one = 1')
    end

    it 'raises error when last item was not a Join' do
      expect { query.on('foo') }.to raise_error(
        Koine::SqlBuilder::Joins::Error,
        'ON can only be performed after a join'
      )
    end
  end
end
