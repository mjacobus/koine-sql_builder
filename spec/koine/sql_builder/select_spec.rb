# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::SqlBuilder::Select do
  describe '#to_s' do
    it 'defaults to *' do
      expect(as_string).to eq('SELECT *')
    end

    it 'handles string' do
      expect(as_string('foobar')).to eq('SELECT foobar')
    end

    it 'handles hahs as aliases' do
      sql = as_string(Name: :name, LastName: :last_name)

      expect(sql).to eq(
        'SELECT Name AS name, LastName AS last_name'
      )
    end

    it 'handle multiple arguments' do
      sql = as_string(:a, { b: :c, d: :e }, %i[f g], h: :i)

      expect(sql).to eq(
        'SELECT a, b AS c, d AS e, f, g, h AS i'
      )
    end
  end
end
