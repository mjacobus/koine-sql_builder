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
require 'object_comparator/rspec'

require_relative './support/spec_helpers'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.order = :random
  config.include MySpecHelpers

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
