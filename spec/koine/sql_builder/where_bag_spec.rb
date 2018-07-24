# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Koine::SqlBuilder::WhereBag do
  let(:adapter) { double(:adapter) }

  subject(:bag) { described_class.new(['foo'], adapter: adapter) }

  before do
    allow(adapter).to receive(:build_conditions) do |args|
      ["#{args.first}-conditioned"]
    end
  end

  it '#maps' do
    result = bag.map do |item|
      "a-#{item}"
    end

    expect(result).to eq(['a-foo-conditioned'])
  end
end
