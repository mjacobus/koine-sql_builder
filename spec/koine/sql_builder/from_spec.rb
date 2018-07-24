# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::SqlBuilder::From do
  describe '#to_s' do
    it 'handles string' do
      expect(as_string('foobar')).to eq('FROM foobar')
    end

    it 'handles hash' do
      expect(as_string(foo: :bar)).to eq('FROM foo bar')
    end

    it 'handles emtpy' do
      expect(as_string).to eq('')
    end

    it 'handles emtpy with spaces' do
      expect(as_string(' ')).to eq('')
    end
  end
end
