# frozen_string_literal: true

if ENV['COVERALLS']
  require 'coveralls'
  Coveralls.wear!
end

if ENV['COVERAGE']
  require 'simplecov'

  SimpleCov.start
end

require 'bundler/setup'
require 'koine/sql_builder'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.order = :random

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

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
