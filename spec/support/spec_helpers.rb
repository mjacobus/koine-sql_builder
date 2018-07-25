# frozen_string_literal: true

module MySpecHelpers
  def immutable(object)
    yield(object).tap do |returned|
      expect(returned).to(
        be_a(object.class),
        "#{returned.class} should have been a #{object.class}"
      )

      expect(returned).not_to(be(object), "#{object.class} should not have been muttated")
    end
  end

  def as_string(*args)
    described_class.new(*args).to_s
  end

  def self.included(base)
    base.class_eval do
      let(:adapter) { Koine::SqlBuilder::Adapter.new }
    end
  end
end
